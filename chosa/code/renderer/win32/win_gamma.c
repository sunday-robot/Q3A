#include <Windows.h>
#include "../tr_local.h"
#include "glw_win.h"

static unsigned short s_oldHardwareGamma[3][256];

/*
** Determines if the underlying hardware supports the Win32 gamma correction API.
*/
void WG_CheckHardwareGamma(void) {
	HDC hDC;

	glConfig.deviceSupportsGamma = 0;

	if (qwglSetDeviceGammaRamp3DFX) {
		glConfig.deviceSupportsGamma = 1;

		hDC = GetDC(GetDesktopWindow());
		glConfig.deviceSupportsGamma = qwglGetDeviceGammaRamp3DFX(hDC, s_oldHardwareGamma);
		ReleaseDC(GetDesktopWindow(), hDC);

		return;
	}

	// non-3Dfx standalone drivers don't support gamma changes, period
	if (glConfig.driverType == GLDRV_STANDALONE)
		return;

	if (!r_ignorehwgamma->integer) {
		hDC = GetDC(GetDesktopWindow());
		glConfig.deviceSupportsGamma = GetDeviceGammaRamp(hDC, s_oldHardwareGamma);
		ReleaseDC(GetDesktopWindow(), hDC);

		if (glConfig.deviceSupportsGamma) {
			//
			// do a sanity check on the gamma values
			//
			if ((HIBYTE(s_oldHardwareGamma[0][255]) <= HIBYTE(s_oldHardwareGamma[0][0])) ||
				(HIBYTE(s_oldHardwareGamma[1][255]) <= HIBYTE(s_oldHardwareGamma[1][0])) ||
				(HIBYTE(s_oldHardwareGamma[2][255]) <= HIBYTE(s_oldHardwareGamma[2][0]))) {
				glConfig.deviceSupportsGamma = 0;
				ri.Printf(PRINT_WARNING, "WARNING: device has broken gamma support, generated gamma.dat\n");
			}

			//
			// make sure that we didn't have a prior crash in the game, and if so we need to
			// restore the gamma values to at least a linear value
			//
			if ((HIBYTE(s_oldHardwareGamma[0][181]) == 255)) {
				int g;

				ri.Printf(PRINT_WARNING, "WARNING: suspicious gamma tables, using linear ramp for restoration\n");

				for (g = 0; g < 255; g++) {
					s_oldHardwareGamma[0][g] = g << 8;
					s_oldHardwareGamma[1][g] = g << 8;
					s_oldHardwareGamma[2][g] = g << 8;
				}
			}
		}
	}
}

/*
** This routine should only be called if glConfig.deviceSupportsGamma is TRUE
*/
void GLimp_SetGamma(const unsigned char red[256], const unsigned char green[256], const unsigned char blue[256]) {
	unsigned short table[3][256];
	int		i, j;
	OSVERSIONINFO	vinfo;

	if (!glConfig.deviceSupportsGamma || r_ignorehwgamma->integer || !glw_state.hDC) {
		return;
	}

	for (i = 0; i < 256; i++) {
		table[0][i] = (((unsigned short) red[i]) << 8) | red[i];
		table[1][i] = (((unsigned short) green[i]) << 8) | green[i];
		table[2][i] = (((unsigned short) blue[i]) << 8) | blue[i];
	}

	// Win2K puts this odd restriction on gamma ramps...
	vinfo.dwOSVersionInfoSize = sizeof(vinfo);
	GetVersionEx(&vinfo);
	if (vinfo.dwMajorVersion == 5 && vinfo.dwPlatformId == VER_PLATFORM_WIN32_NT) {
		Com_DPrintf("performing W2K gamma clamp.\n");
		for (j = 0; j < 3; j++) {
			for (i = 0; i < 128; i++) {
				if (table[j][i] >((128 + i) << 8)) {
					table[j][i] = (128 + i) << 8;
				}
			}
			if (table[j][127] > 254 << 8) {
				table[j][127] = 254 << 8;
			}
		}
	} else {
		Com_DPrintf("skipping W2K gamma clamp.\n");
	}

	// enforce constantly increasing
	for (j = 0; j < 3; j++) {
		for (i = 1; i < 256; i++) {
			if (table[j][i] < table[j][i - 1]) {
				table[j][i] = table[j][i - 1];
			}
		}
	}


	if (qwglSetDeviceGammaRamp3DFX) {
		qwglSetDeviceGammaRamp3DFX(glw_state.hDC, table);
	} else {
		Com_Printf("ignore SetDeviceGammaRamp.\n");
	}
}

/*
*/
void WG_RestoreGamma(void) {
	if (glConfig.deviceSupportsGamma) {
		if (qwglSetDeviceGammaRamp3DFX) {
			qwglSetDeviceGammaRamp3DFX(glw_state.hDC, s_oldHardwareGamma);
		} else {
			HDC hDC = GetDC(GetDesktopWindow());
			SetDeviceGammaRamp(hDC, s_oldHardwareGamma);
			ReleaseDC(GetDesktopWindow(), hDC);
		}
	}
}
