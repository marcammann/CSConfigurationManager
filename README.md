# TODO: I'm yet to be documented.

# Introduction

CSConfigurationManager allows to load configurations from a PLIST or JSON files in iOS, categorized by `CONFIGURATION` constant.
Also allows to have Default values, which get overwritten by the corresponding `CONFIGURATION` values.

`CONFIGURATION` is the name of the constant that XCode uses for the name of the build configuration.
So if you have a build configuration called `Release` and one called `Debug`, you could set up a configuration like this:

__Configuration.json__
```
{
	"Default": {
		"BaseURL": "http://google.com",
		"APIVersion": "v2.x"
		"LogLevel": "Error"
	},
	"Release": {
		"APIVersion": "v2.01"
	},
	"Debug": {
		"LogLevel": "Debug"
	}
}
```

If you request values from the configuration manager when you built for target `Release` your returned value for `APIVersion` would be `v2.01`.

# Usage

```
CSConfigurationManager *manager = [[CSConfigurationManager alloc] initWith]
```


# Setup

STRINGIFY(X)=#X
BUILD_TARGET=STRINGIFY(${CONFIGURATION})


USERNAME=STRINGIFY(${USER})
CONFIGURATION_${CONFIGURATION}


