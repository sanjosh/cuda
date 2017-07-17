#include <cuda.h>

int main() {

	cuInit(0);  

	int cnt;
	cuDeviceGetCount( &cnt );

	for (int it = 0; it < cnt ; ++ it) {

		CUdevice dev;
		char name[1024];
		int major, minor;
		size_t bytes;
		CUdevprop properties;

		cuDeviceGet              ( &dev, it );
		cuDeviceGetName          ( name, sizeof(name), dev );
		cuDeviceComputeCapability( &major, &minor,     dev );
		cuDeviceTotalMem         ( &bytes,             dev );
		cuDeviceGetProperties    ( &properties,        dev );
		// or cuDeviceGetAttribute
	}
}
