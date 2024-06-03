-- Require necessary libraries
local lfs = require("lfs")
local math = require("math")
local os = require("os")

-- Path to the gifs directory
local gifs_path = "./anim"

-- Seed the random number generator
math.randomseed(os.time())

-- Function to list all gif files in the gifs directory
local function list_gif_files(path)
    local gif_files = {}
    for file in lfs.dir(path) do
        if file:match("%.gif$") then
            table.insert(gif_files, file)
        end
    end
    return gif_files
end

-- Get all gif files
local gif_files = list_gif_files(gifs_path)

-- Ensure the gif_files are valid
if #gif_files == 0 then
    error("No GIF files found in the directory: " .. gifs_path)
end


-- Generate HTML content with JavaScript for random GIFs
local gif_html_content = [[
<div id="random-gif-container">
    <img id="random-gif" src="./anim/]] .. gif_files[1] .. [[" width="500px" onclick="changeGif()" style="cursor: pointer;">
</div>
<script>
    const gifs = ["]] .. table.concat(gif_files, '","') .. [["];
    let currentGif = 0;
    function changeGif() {
        currentGif = (currentGif + 1) % gifs.length;
        document.getElementById("random-gif").src = "./anim" + gifs[currentGif];
    }
</script>
]]

-- Path to the README file
local readme_path = "./README.md"

-- Read the current README content
local readme_file = io.open(readme_path, "r")
local readme_content = readme_file:read("*all")
readme_file:close()

-- Placeholder to replace in the README
local placeholder = "<!-- RANDOM_GIF_PLACEHOLDER -->"

-- Replace the placeholder with the GIF HTML content
local updated_readme_content = readme_content:gsub(placeholder, gif_html_content)

-- Write the updated content back to the README file
local readme_file = io.open(readme_path, "w")
readme_file:write(updated_readme_content)
readme_file:close()

print("Successfully updated README.md with interactive GIF")

-- Debug: Print the generated HTML content
print(gif_html_content)