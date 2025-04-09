import Foundation
import PackagePlugin

@main
struct ElementaryCSSGeneratorPlugin: CommandPlugin {
    let command: String = "generate-css"
    let defaultOutputPath: String = "elementary.css"

    func performCommand(
        context: PackagePlugin.PluginContext,
        arguments: [String]
    ) async throws {
        // Find the executable target
        let tool = try context.tool(named: "ElementaryCSSGeneratorTool")

        // Parse command line arguments
        var argumentExtractor = ArgumentExtractor(arguments)
        let outputOptions = argumentExtractor.extractOption(named: "output")
        let outputPath = outputOptions.isEmpty ? defaultOutputPath : outputOptions[0]

        // Check for unused arguments
        let unusedArguments = argumentExtractor.remainingArguments
        guard unusedArguments.isEmpty else {
            print("\nUsage: swift package \(command) [--output <path>]")
            print("       Default output path: \(defaultOutputPath)")
            print("\nUnrecognized arguments: \(unusedArguments.joined(separator: " "))")
            Diagnostics.error("Invalid command line arguments")
            return
        }

        print("Generating CSS and saving to: \(outputPath)")

        // Create a pipe to capture the output
        let pipe = Pipe()

        // Setup the process
        let process = Process()
        process.executableURL = tool.url
        process.standardOutput = pipe

        // Run the tool
        try process.run()

        // Capture the output data
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        process.waitUntilExit()

        // Check if the process completed successfully
        guard process.terminationStatus == 0 else {
            Diagnostics.error("CSS generation tool failed with exit code \(process.terminationStatus)")
            return
        }

        // Convert output to string
        guard let cssContent = String(data: data, encoding: .utf8) else {
            Diagnostics.error("Failed to decode CSS content from tool output")
            return
        }

        // Make sure the directory exists
        let outputURL = URL(fileURLWithPath: outputPath)
        let directory = outputURL.deletingLastPathComponent().path
        if !directory.isEmpty && directory != "." {
            try FileManager.default.createDirectory(
                atPath: directory,
                withIntermediateDirectories: true
            )
            print("Created directory: \(directory)")
        }

        // Write the CSS content to the output file
        try cssContent.write(to: outputURL, atomically: true, encoding: .utf8)

        print("Successfully generated CSS file at: \(outputPath)")
    }
}
