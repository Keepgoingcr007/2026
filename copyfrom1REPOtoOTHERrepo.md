# ====================================================================
# PHASE 1: ISOLATE THE PROJECT AND INITIALIZE GIT LOCAL REPOSITORY
# ====================================================================

# Step 1: Initialize a brand new, independent Git repository in your current folder
git init

# Step 2: Create a .gitignore file to ensure your private-key/ folder is never tracked or leaked
Set-Content .gitignore -Value "private-key/"

# Step 3: Stage all your Terraform settings files, the README, and your new .gitignore
git add *.tf README.md .gitignore

# Step 4: Permanently save your staged files to your local history with a version tag
git commit -m "06112026-v1"


# ====================================================================
# PHASE 2: RENAME THE BRANCH AND PUSH TO GITHUB
# ====================================================================

# Step 5: Rename your default branch from 'master' to your target date name
git branch -m 06112026

# Step 6: Link your local repository to your online GitHub repository container
git remote add origin https://github.com/Keepgoingcr007/03-Terraform-Settings-Providers-Resources

# Step 7: Push your specific branch online and lock in the default tracking path (-u)
git push -u origin 06112026


# ====================================================================
# PHASE 3: CONSOLIDATE INTO YOUR MAIN "2026" REPOSITORY
# ====================================================================

# Step 8: Move out of the practice folder and change directory into your main 2026 project folder
cd D:\June2026-practice\2026

# Step 9: Create and switch to the target branch inside your main repository workspace
git checkout -b 06112026

# Step 10: Copy the entire practice directory straight into your main workspace directory
Copy-Item -Path ".\June-Practice\03-Terraform-Settings-Providers-Resources" -Destination ".\" -Recurse -Force

# Step 11: CRITICAL - Delete the inner hidden .git folder from the copied directory so it doesn't break tracking
Remove-Item -Path ".\03-Terraform-Settings-Providers-Resources\.git" -Recurse -Force -ErrorAction SilentlyContinue

# Step 12: Stage the newly moved practice directory inside your main repository workspace
git add 03-Terraform-Settings-Providers-Resources/

# Step 13: Commit the integrated practice folder into your main repository project timeline
git commit -m "Copy EC2 Terraform settings into main 2026 repository"

# Step 14: Push the consolidated branch up to your main cloud repository architecture
git push -u origin 06112026
