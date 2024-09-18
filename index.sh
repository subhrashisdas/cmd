#!/bin/bash

# Retrieves the IP address associated with the en0 network interface.
#
# Usage:
#   ip
#
# Example:
#   ip
#   This will output the IP address of the en0 network interface.

function ip() {
  ipconfig getifaddr en0
}

# Computes the SHA-256 hash of the specified file.
#
# Usage:
#   hash <file-path>
#
# Parameters:
#   <file-path> - The path to the file for which the hash is to be computed.
#
# Example:
#   hash /path/to/file.txt
#   This will output the SHA-256 hash of 'file.txt'.

function hash() {
  shasum -a 256 $1
}

# Synchronizes the contents of the /Volumes/SD/ directory to the ~/Backup directory.
# Excludes hidden files and directories and deletes files in the destination that are not present in the source.
#
# Usage:
#   sync_backup
#
# Example:
#   sync_backup
#   This will synchronize files from /Volumes/SD/ to ~/Backup, excluding hidden files and deleting obsolete files in the destination.

function sync_backup() {
  rsync -av --exclude='.*' --delete /Volumes/SD/ ~/Backup
}

# Updates Homebrew, upgrades all installed formulae, cleans up outdated versions, and runs diagnostics.
#
# Usage:
#   brewski
#
# Example:
#   brewski
#   This will perform the following Homebrew maintenance tasks: update, upgrade, cleanup, and doctor.

function brewski() {
  brew update
  brew upgrade
  brew cleanup
  brew doctor
}

# Deletes the local and remote repository, then creates a new repository with a single initial commit.
#
# Usage:
#   delete_all_commits <repository-name> <commit-message>
#
# Parameters:
#   <repository-name> - The name of the GitHub repository to be reset (e.g., "gist").
#   <commit-message> - The commit message for the new initial commit (e.g., "Reset history").
#
# Example:
#   delete_all_commits gist "Reset history"
#   This will delete the repository 'gist' from GitHub, create a new repository with the same name, and push a new commit with the message "Reset history".

delete_all_commits() {
    local repo_name="$1"
    local commit_message="$2"
    local repo_url="git@github.com:subhrashisdas/$repo_name.git"
    local temp_dir="/tmp/${repo_name}"

    git clone "$repo_url" "$temp_dir"
    cd "$temp_dir" || return
    rm -rf .git
    git init -b main
    git add -A
    git commit -m "$commit_message"
    git remote add origin "$repo_url"
    git push origin main --force
    cd - || return
    rm -rf "$temp_dir"
}

# Strips the audio track from all video files in the specified directory and saves the processed files to another directory.
#
# Usage:
#   strip_audio_from_videos <video-dir> <output-dir>
#
# Parameters:
#   <video-dir> - The directory containing the video files from which audio will be removed.
#   <output-dir> - The directory where the processed videos will be saved.
#
# Example:
#   strip_audio_from_videos /path/to/videos /path/to/output
#   This will process all video files in '/path/to/videos', remove their audio tracks, and save the output to '/path/to/output'.

strip_audio_from_videos() {
    local video_dir="$1"
    local output_dir="$2"

    mkdir -p "$output_dir"
    shopt -s nocaseglob

    for video_file in "$video_dir"/*.{mp4,MP4,mkv,MKV,avi,AVI,mov,MOV,flv,FLV,wmv,WMV}; do
        filename=$(basename -- "$video_file")
        filename_no_ext="${filename%.*}"
        output_file="${output_dir}/${filename_no_ext}.${video_file##*.}"
        ffmpeg -y -i "$video_file" -c:v copy -an -map_metadata 0 "$output_file"
    done
    
    shopt -u nocaseglob
}
