# Step 1: Start with the official n8n image
# IMPORTANT: Use the SAME n8n version you're currently running!
# Find this version in your Render service settings or n8n dashboard (like in image_1bb6ac.png).
# Replace 'latest' below with your specific version if you know it (e.g., '1.23.0'). If not, 'latest' might work but matching version is best.
FROM n8nio/n8n:latest

# Step 2: Temporarily switch to the 'root' user (like an administrator)
# This is needed for the next step to enable 'pnpm'.
USER root

# Step 3: Enable 'pnpm' (a special tool the assistant needs for installation)
# 'corepack enable pnpm' is the recommended way to make pnpm available.
RUN corepack enable pnpm
# What if this 'corepack' step fails during the build?
# An alternative (but try corepack first) would be to replace the line above with:
# RUN npm install -g pnpm

# Step 4: Switch back to the standard 'node' user
# n8n normally runs as 'node' for better security.
USER node

# Step 5: Define where n8n keeps its user-specific files
# This is usually '/home/node/.n8n'. We'll refer to this as N8N_USER_FOLDER.
ARG N8N_USER_FOLDER=/home/node/.n8n

# Step 6: Create the folder where custom n8n extensions live
# The path will be /home/node/.n8n/custom/extensions/
# The 'mkdir -p' command creates these folders if they don't already exist.
RUN mkdir -p ${N8N_USER_FOLDER}/custom/extensions

# Step 7: Copy your assistant's zip file into the Docker image
# This takes 'n8n-assistant-source.zip' from your 'my-custom-n8n' folder
# and puts it into a temporary location inside the Docker image.
# '--chown=node:node' ensures the 'node' user owns the file.
COPY --chown=node:node n8n-assistant-source.zip /tmp/n8n-assistant-source.zip

# Step 8: Unzip the assistant's source code
# This unzips the file into another temporary folder inside the image.
RUN mkdir -p /tmp/unzipped_assistant_source && \
    unzip /tmp/n8n-assistant-source.zip -d /tmp/unzipped_assistant_source/ && \
    rm /tmp/n8n-assistant-source.zip
# This command does three things in order:
# 1. 'mkdir -p ...': Creates a temporary folder for the unzipped files.
# 2. 'unzip ...': Unzips your 'n8n-assistant-source.zip' into that folder.
# 3. 'rm ...': Deletes the .zip file (we don't need it anymore since it's unzipped).

# Step 9: Move the important part of the assistant to the right place
# Your zip file contains several things, but the actual n8n extension is in 'n8n_assistant_package/'.
# We move this 'n8n_assistant_package/' folder to n8n's custom extensions folder.
# AND we rename 'n8n_assistant_package/' to 'n8n-assistant' because the assistant's setup guide expects this name.
RUN mv /tmp/unzipped_assistant_source/n8n_assistant_package ${N8N_USER_FOLDER}/custom/extensions/n8n-assistant && \
    rm -rf /tmp/unzipped_assistant_source
# This command does two things in order:
# 1. 'mv ...': Moves the 'n8n_assistant_package/' folder to become '/home/node/.n8n/custom/extensions/n8n-assistant'.
# 2. 'rm -rf ...': Deletes the temporary '/tmp/unzipped_assistant_source' folder and anything else that was in the zip (like 'app/', 'knowledge_base/', documentation files, etc.), as they are not needed for *this specific n8n extension installation*.

# Step 10: Change the current directory to the assistant's folder
# This is like using the 'cd' command to go into the '/home/node/.n8n/custom/extensions/n8n-assistant' folder.
WORKDIR ${N8N_USER_FOLDER}/custom/extensions/n8n-assistant

# Step 11: Install all the software bits (dependencies) the assistant needs
# The 'pnpm install' command looks at a file inside the assistant's folder
# and downloads all the necessary small tools and libraries for it to work.
RUN pnpm install

# Step 12: "Build" the assistant
# The 'pnpm build' command takes the assistant's code and prepares it
# into the final form that n8n can understand and use.
RUN pnpm build

# Step 13: Change the working directory back (optional, but good practice)
# This just sets the current directory back to the n8n user's home.
WORKDIR /home/node/

# That's it! The original n8n image (from Step 1) already knows how to start n8n.
# When this new, customized image runs, n8n should automatically find and load your assistant.