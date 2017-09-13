Kanban Tool Plugin
==================
Description
-----------
A Redmine plugin which connects kanbantool.com with Redmine by letting users choose to automatically add an entry into Kanban Tool when creating a new issue.

Options
-------
 - Give permission to use the plugin to user roles and projects (as module)
 - Control the access to each Kanban board per user role
 - Hide stages/swimlanes
 - Hide/deactivate certain input types such as the description for a new Kanban entry
 - Option to pass new Redmine issue ID to a Kanban custom field

Instructions
------------
### 1. Installing Kanban Tool Plugin in Redmine

#### Installing straight from GitHub
1. Using the commandline, change to Redmine's plugin directory:
``` [your_redmine_directory]/plugins ```
2. Type in the following command:
``` git clone git://github.com/gyselroth/redmine-plugin-kanbantool.git ```
#### Downloading ZIP File
Another way to install the plugin is to download the ZIP file from [here](https://github.com/gyselroth/redmine-plugin-kanbantool/archive/master.zip), unzip it and move the folder to the Redmine's plugin directory.

### 2. Setting up Kanban Tool Plugin

#### 2.1 Creating an API Token
To give the plugin access to your Kanban Tool, you first need an API Token. In case you already have one, proceed to step 2.2.

1. Go to the Dashboard of your Kanban Tool website
2. Open your profile go to API access
3. Generate an API token
4. Make sure that your account has access to all the boards you want, as the API token is limited to that

#### 2.2 Entering API Token & Domain
1. Go to Administration page of your Redmine installation
2. Then to ``` Plugins > Kanban Tool > Configure ``` to access the plugin's settings page
3. Enter the API Token and domain of your Kanban Tool
4. After applying your changes, all your boards will be loaded into the plugin's settings page

#### 2.3 Hiding Stages/Swimlanes
To hide stages and swimlanes, simply check the boxes next to them. They will not appear on the New issue page of Redmine and can not be used anymore.

#### 2.4 User Role for Board Access
Each board can be assigned to multiple user roles. However, the roles need to have the Kanban Tool permission. See 3.2 how to set up. Roles with this permission will appear in the plugin's settings page. Once assigned, only users with the allowed user role will have the option to create a ticket in the respective board.

#### 2.5 Hiding Input Fields
To hide an input field, follow the same procedure as 2.3.
- As a Kanban title is necessary in order to create a new Kanban entry, the title of the Redmine ticket will be used if hidden.
- If the ``` Kanban stage ``` field is hidden, a new Kanban entry will be placed in the most left of the corresponding Kanban board.
- If the ```Kanban swimlane ``` field is hidden, a new Kanban entry will be placed in the top of the corresponding Kanban board.
- If ``` Kanban stage ``` and ```Kanban swimlane ``` are hidden, a new Kanban entry appears in the top left corner.

### 3. Using Kanban Tool Plugin

#### 3.1 Activating the Kanban Tool Module for a Project
The plugin can be activated separately for each Redmine project. To do so, go to ``` Administration > Projects > [your_project] > Modules ``` and check ``` Kanban Tool ```.

#### 3.2 Giving Kanban Tool Permission to User Roles
In order to use the Kanban Tool plugin, a user needs to have a user role with the ``` Use Kanban Tool ``` permission. To give a user role the ``` Use Kanban Tool ``` permission, go to ``` Administration > Roles and permissions > [your_user_role] ``` and check the ``` Use Kanban Tool ``` box.

#### 3.3 Creating a new Kanban Entry with Redmine
**Before you proceed, check that:**
- The current project you are in has the ``` Kanban Tool ``` module activated (see 3.1)
- You are logged in with a user role that has the ``` Use Kanban Tool ``` permission (see 3.2)
- Your user role is assigned to at least one board (see 2.4)

1. Go to the ``` New issue ``` page to create a new issue in Redmine
2. A new panel in the bottom section appears
3. Select your Kanban options and enter/select data (depending on your settings)
4. If no board is chosen, no Kanban entry will be created

Author and License
------------------
Copyright 2017 gyselroth™ (http://www.gyselroth.com)

MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
