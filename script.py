 
import os
import subprocess

def main():
    output_file = "result.txt"
    current_dir = os.getcwd()

    # Create or clear the result.txt file
    with open(output_file, 'w', encoding='utf-8') as f:
        pass  # Just to clear the file

    # Add a header and tree command output to the result file
    with open(output_file, 'a', encoding='utf-8') as f:
        f.write("File structure:\n")
        try:
            # Execute the tree command and capture its output
            tree_output = subprocess.check_output(['tree', current_dir], stderr=subprocess.DEVNULL, text=True)
            f.write(tree_output)
        except subprocess.CalledProcessError:
            f.write("Error generating tree structure.\n")
        f.write("\n\n")  # Add two new lines

    # Function to recursively read files
    def read_files(dir_path):
        for root, dirs, files in os.walk(dir_path):
            for file in files:
                file_path = os.path.join(root, file)
                # Write the file path
                with open(output_file, 'a', encoding='utf-8') as f:
                    f.write(f"File path: [{file_path}]\n")
                try:
                    # Write the file content
                    with open(file_path, 'r', encoding='utf-8') as file_content:
                        content = file_content.read()
                    with open(output_file, 'a', encoding='utf-8') as f:
                        f.write(content + "\n\n")
                except (UnicodeDecodeError, PermissionError, OSError) as e:
                    with open(output_file, 'a', encoding='utf-8') as f:
                        f.write(f"Could not read file: {e}\n\n")

    # Start reading files from the current directory
    read_files(current_dir)

    print(f"Result file created: {output_file}")

if __name__ == "__main__":
    main()
