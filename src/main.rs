use std::process::Command;
use std::str;

fn main() {
    // Define the path to the binary
    let binary_path = "./lib/wifi_scanner_macos";

    println!("Running the command: {}", binary_path);


    let output_bytes = Command::new(binary_path)
        .output()
        .expect("Failed to execute process");

  // convert stdout bytes to a UTF-8 string
  let stdout_result = str::from_utf8(&output_bytes.stdout);

  match stdout_result {
    Ok(stdout_str) => {
        // If the conversion is successful, print the output
        println!("Output: {}", stdout_str);
    },
    Err(e) => {
        // If there's an error, print the error
        eprintln!("Failed to convert output to UTF-8: {}", e);
    }
}
}
