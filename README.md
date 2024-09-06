
# WiFi Scanner

## Overview

The **WiFi Scanner** is a macOS command-line utility written in Objective-C that scans for available Wi-Fi networks and outputs their details in JSON format. This tool uses the `CoreWLAN` framework to access Wi-Fi network information and returns data such as SSID, BSSID, RSSI, noise level, channel, and more.

The output is formatted as a JSON object with a clear structure, making it suitable for integrating with other tools or services that consume JSON data.

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

## Usage

### Requirements

- macOS (since the `CoreWLAN` framework is used, this will only run on macOS).
- Xcode Command Line Tools (for `clang` compiler).

### Compiling the Program

1. Clone or download this repository.
2. Open a terminal and navigate to the root of the project.
3. Use the following shell script to compile and run the program:

```bash
./build_and_run.sh
```

This script will:
- Compile the source file located in the `src/` folder.
- Place the compiled binary in the `build/` folder.
- Run the compiled binary and output the Wi-Fi network information in JSON format.

### Running the Program

Once the program is compiled, it can be run from the `build/` directory:

```bash
./build/wifi_scan
```

The program will scan for available Wi-Fi networks and output the results as a JSON object in the terminal.

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

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

This Wi-Fi scanner utility was built by Marc Mouries.
