
# WiFi Scanner

## Overview

The **WiFi Scanner** is a macOS command-line utility written in Objective-C that scans for available Wi-Fi networks and outputs their details in JSON format. This tool uses the `CoreWLAN` framework to access Wi-Fi network information and returns data such as SSID, BSSID, RSSI, noise level, channel, and more.

The output is formatted as a JSON object with a clear structure, making it suitable for integrating with other tools or services that consume JSON data.

The project also includes a Rust integration that runs the compiled Wi-Fi scanner binary (`wifi_scanner_macos`) and processes its output.

## Features

- Scans for all available Wi-Fi networks on your machine.
- Outputs network properties in a clean, structured JSON format.
- Ensures the `SSID` is the first field in the JSON output, followed by other properties in alphabetical order.
- Includes detailed information such as:
  - SSID (network name)
  - BSSID (MAC address of the access point)
  - RSSI (signal strength)
  - Noise level
  - Wi-Fi channel
  - Beacon interval
  - Country code
  - Information element data

## Project Structure

```
.
├── LICENSE
├── README.md
├── build_and_run.sh
├── lib
│   └── wifi_scanner_macos       # Compiled Wi-Fi scanner binary
└── src
    ├── main.rs                  # Rust code to run the Wi-Fi scanner binary
    └── lib
        └── macos
            └── wifi_scanner.m   # Objective-C source for the Wi-Fi scanner
```

## Usage

### Requirements

- macOS (since the `CoreWLAN` framework is used, this will only run on macOS).
- Xcode Command Line Tools (for compiling the Objective-C code).
- Rust and Cargo (for running the Rust integration).

### Compiling the Wi-Fi Scanner (Objective-C)

1. Open a terminal and navigate to the root of the project.
2. Use the following shell script to compile the Objective-C Wi-Fi scanner and run it:

```bash
./build_and_run.sh
```

This script will:
- Compile the source file located in the `src/lib/macos` folder.
- Place the compiled binary in the `lib/` folder.
- Run the compiled binary and output the Wi-Fi network information in JSON format.

### Running the Wi-Fi Scanner using Rust

Once the Objective-C binary is compiled (`lib/wifi_scanner_macos`), you can use Rust to execute the binary and process its output:

1. Compile and run the Rust program:

```bash
cargo run
```

This will:
- Execute the compiled `wifi_scanner_macos` binary.
- Capture the JSON output and display it in a human-readable format.

### Example Output

```json
{
  "status": "success",
  "data": [
    {
      "SSID": "Network1",
      "BSSID": "00:11:22:33:44:55",
      "RSSI": -70,
      "Noise": -90,
      "Channel": 6,
      "BeaconInterval": 100,
      "CountryCode": "US",
      "IBSS": false,
      "SSIDData": "Network1",
      "InformationElementData": "Base64EncodedData"
    },
    {
      "SSID": "Network2",
      "BSSID": "11:22:33:44:55:66",
      "RSSI": -50,
      "Noise": -85,
      "Channel": 11,
      "BeaconInterval": 100,
      "CountryCode": "US",
      "IBSS": false,
      "SSIDData": "Network2",
      "InformationElementData": "Base64EncodedData"
    }
  ]
}
```

### Error Handling

If an error occurs during the scan, such as when the Wi-Fi interface is unavailable, the program will output an error message in the JSON format:

```json
{
  "status": "failure",
  "message": "Error scanning for networks: <error message>"
}
```

## Author

This Wi-Fi scanner utility was built by Marc Mouries.
