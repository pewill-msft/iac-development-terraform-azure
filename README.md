# iac-development-terraform-azure

Development environment setup for Infrastructure as Code for Azure using Terraform

## Overview
There are several options to configure your development environment for working with Azure and Terraform. This repository provides guides how to use DevContainers and GitHub Codespaces to speed up the setup process and make it easier to onboard new team members who will work with the terraform code.

The repo includes a devcontainer.json file where the development environment is defined and also a simple terraform code to create a resource group and Azure SQL datbase in Azure

> [!NOTE]
> Part of this guide assumes development is done on a Windows machine. If you are using a different OS, you may need to adjust or omit some of the steps.

## Setup

### Enable WSL 2
To be able to run Linux containers on Windows, you need to enable WSL 2.

Open PowerShell as Administrator and run the following command to enable WSL 2:

```powershell
wsl --install
```
This will enable WSL 2 with default settings (including installing Ubuntu as the default Linux distribution). If you want to use a different Linux distribution, you can install it from the Microsoft Store.

See [How to install Linux on Windows with WSL](https://learn.microsoft.com/en-us/windows/wsl/install) for more information.

After installation of WSL 2 you will be prompted to create a new user account and password for the Linux distribution. Also make sure to update and upgrade the Linux packes for your distribution, see [Set up a WSL development environment](https://learn.microsoft.com/en-us/windows/wsl/setup/environment)


### Install Docker Desktop
To be able to run devcontainers locally on your machine you need to install docker. For Windows, you can use [Docker Desktop](https://www.docker.com/products/docker-desktop) which makes the installation process very easy.

> [!IMPORTANT]
> Docker Desktop comes with licensing restrictions. Make sure to review the [Install Docker Desktop on Windows](https://docs.docker.com/desktop/install/windows-install/) before you proceed with the installation. 

Open PowerShell as Administrator and run the following command to install Docker Desktop
    
```powershell
winget install Docker.Desktop 
```

### Fork or clone this repository
Create or reuse an existing GitHub repository where you will store your Terraform code.

To use the starter files from in this repository, clone it to your local machine and then push it to your own GitHub repository.


```powershell

cd c:\\path-to-your-repo

# Clone this repository to your local machine
git clone https://github.com/pewill-msft/iac-development-terraform-azure.git

# Add your existing repository as a remote 
git remote add repo2 https://github.com/your-username/other-repo.git

# Fetch the existing content from your remote repository 
git fetch repo2

# Merge the content from the other repository into your local repository. Don't include any commit history from the other repository.
git merge repo2/main --allow-unrelated-histories --squash

# Commit the changes 
git commit -m "Merge starer files"

# Push the code to your own repository
git push origin main

```
> [!TIP]
> If the `git` commands feels overwhelming, you can also clone this repository and manually copy the files to your own repository.

> [!NOTE]
> Technically you could do a fork of this repository to your own GitHub account, but since you are not planning to do any changes that contributes back to the original repository, it is better to clone the repository and push it to your own GitHub account.

### Review repository content and Sign in to Azure
Open the repository in VS Code 
```powershell
# Navigate to the repository folder
cd c:\\path-to-your-repo

# Open the repository in VS Code
code .

```

Review the content of the repository. The repository contains a `devcontainer.json` file which defines the development environment. This file is used when accessing the repository using GitHub Codespaces or when using a container locally.
```json
{
	"name": "Ubuntu Terraform Development for Azure",
	"image": "mcr.microsoft.com/devcontainers/base:jammy",
	"features": {
		"ghcr.io/devcontainers/features/azure-cli:1": { },
		"ghcr.io/devcontainers/features/terraform:1": { }
	},
	"customizations": {
		"vscode": {
			"extensions": [
				"hashicorp.terraform",
				"ms-azuretools.vscode-azurestorage",
				"ms-azuretools.vscode-azureresourcegroups",
				"ms-azuretools.vscode-azurevirtualmachines"
			]
		}
	}
}
```
The Dev Container is based on 'Ubuntu' and includes `Azure CLI` and `Terraform` as well as some VS Code extensions for working with Azure and Terraform.

The repository also contains a simple Terraform code to create a resource group and an Azure SQL database in Azure. The Terraform code is located in `src` folder.

With the repository open in VS Code, you can either edit the files dirctly and push to GitHub or start the development environment using a container by entering the following command in the VS Code command palette (Ctrl+Shift+P) and select `Dev Containers: Reopen in Container`

This will open the same repository in a container and install the extensions, tooling and other dependencies as defined in the `devcontainer.json` file. The repository files are mounted into the container and hence resides in the file system of your local machine. The shell will be a bash shell and you can use the Linux commands to navigate the file system.

With the repository open in a container, you can start working with the Terraform code and Azure resources.
Start by authenticating to Azure using the Azure CLI
```bash

az login

```
The login command will open a browser window where you can authenticate to Azure. 

The Dev Container also installs a few Azure Extensions for VS Code to make it easier to brwose and manage Azure resources.
You can log in to the Azure account using the command palette (Ctrl+Shift+P) and select `Azure: Sign In azureResourceGroups.login`

> [!NOTE]
> If you also have the Azure Account Extension installed there will be two options for signing in to Azure. Make sure to select the `azureResourceGroups.login` option. See https://github.com/microsoft/vscode-azureresourcegroups/releases/tag/v0.8.0 for details.

> [!TIP]
> You don't need to sign in to Git again since the Dev Container will reuse the credential helper already configured in your host machine

### Initialize Terraform and Deploy to Azure
Run `terraform init` to initialize the Terraform deployment. This command downloads the Azure provider required to manage your Azure resources.
```bash
terraform init -upgrade
```
Run terraform plan to create an execution plan.

```bash
terraform plan -out main.tfplan
```
Run terraform apply to apply the execution plan to your Azure subscription 

```bash
terraform apply main.tfplan

```





