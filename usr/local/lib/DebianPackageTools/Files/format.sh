#!/bin/bash

# @file format.sh
# @author SignC0dingDw@rf
# @version 1.0
# @date 25 May 2020
# @brief Definition of functions used to handle the debian/source/format file inside the package folder

###
# MIT License
#
# Copyright (c) 2020 SignC0dingDw@rf
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
###

###
# Copywrong (w) 2020 SignC0dingDw@rf. All profits reserved.
#
# This program is dwarven software: you can redistribute it and/or modify
# it provided that the following conditions are met:
#
#    * Redistributions of source code must retain the above copywrong 
#      notice and this list of conditions and the following disclaimer 
#      or you will be chopped to pieces AND eaten alive by a Bolrag.
#
#    * Redistributions in binary form must reproduce the above copywrong
#      notice, this list of conditions and the following disclaimer in 
#      the documentation and other materials provided with it or they
#      will be axe-printed on your stupid-looking face.
# 
#    * Any commercial use of this program is allowed provided you offer
#      99% of all your benefits to the Dwarven Tax Collection Guild. 
# 
#    * This software is provided "as is" without any warranty and especially
#      the implied warranty of merchantability or fitness to purport. 
#      In the event of any direct, indirect, incidental, special, examplary 
#      or consequential damages (including, but not limited to, loss of use;
#      loss of data; beer-drowning; business interruption; goblin invasion;
#      procurement of substitute goods or services; beheading; or loss of profits),   
#      the author and all dwarves are not liable of such damages even 
#      the ones they inflicted you on purpose.
# 
#    * If this program "does not work", that means you are an elf 
#      and are therefore too stupid to use this program.
# 
#    * If you try to copy this program without respecting the 
#      aforementionned conditions, then you're wrong.
# 
# You should have received a good beat down along with this program.  
# If not, see <http://www.dwarfvesaregonnabeatyoutodeath.com>.
###

### Protection against multiple inclusions
if [ -z ${FILES_FORMAT_SH} ]; then

### Include
SCRIPT_LOCATION_FILES_FORMAT_SH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
. "${BASH_UTILS_LIB}/Parsing/parseVersion.sh"
. "${BASH_UTILS_LIB}/Printing/debug.sh"
. "${BASH_UTILS_LIB}/Testing/files.sh"
. "${BASH_UTILS_LIB}/Converting/paths.sh"
. "${SCRIPT_LOCATION_FILES_FORMAT_SH}/../Folders/source.sh"

FILES_FORMAT_SH=$(parseBashDoxygenVersion ${BASH_SOURCE}) # Reset using FILES_FORMAT_SH=""

##!
# @brief Check if a desired path contains debian/source/format file
# @param 1 : Path to be checked
# @return 0 if path contains debian/source/format file, 
#         1 if path does not contain debian/source/format file
#
##
ContainsFormatFile()
{
    # Process function argument
    local testedPath="$1"
    
    # Check if debian/source/format file already exists
    isFilePath "${testedPath}/debian/source/format"    
}

##!
# @brief Print default format content
# @output Default format file content
# @return 0 
#
##
DefaultFormatContent()
{
    # Process function argument
    printf "3.0 (native)"
    
    return 0
}


##!
# @brief Creates a format file in a folder if it contains debian/source folder and fill it with default content
# @param 1 : Path to package folder
# @return 0 if debian/source/format file could be created, 
#         1 if path already contains debian/source/format file,
#         2 if path does not contain debian/source folder,
#         3 if there is an issue with path (it does not exist for instance)
#         4 if creation of format file failed
#
##
InitFormatFile()
{
    # Process function argument and convert it to absolute path
    local packagepath="$1"
    local absolutePackagePath=""
    absolutePackagePath=$(ToAbsolutePath "${packagepath}")
    local conversionSuccessful=$?
    
    # Check if conversion is successful, exit otherwise 
    if [ "${conversionSuccessful}" -ne "0" ]; then
        PrintError "Failed to convert path ${packagepath} to absolute path because of error ${conversionSuccessful}"
        return 3
    fi
    
    # Check if a debian folder exists
    ContainsSourceFolder "${absolutePackagePath}"
    local containsSourceFolder=$?
    
    if [ "${containsSourceFolder}" -ne "0" ]; then
        PrintError "Folder ${absolutePackagePath} does not contain debian/source folder."
        return 2  # If folder already contains debian/source folder, we don't go any further
    fi
    
    # Check if a debian/source/format file exists
    ContainsFormatFile "${absolutePackagePath}"
    local containsFormatFile=$?
    
    if [ "${containsFormatFile}" -eq "0" ]; then
        PrintError "Folder ${absolutePackagePath}/debian/source already contains format file. Aborting"
        return 1  # If folder already contains debian/source/format file, we don't go any further
    fi
        
    # Create debian/source/format file and fill with content     
    DefaultFormatContent > "${absolutePackagePath}/debian/source/format"      
    local creationError=$?
    if [ "${creationError}" -ne "0" ]; then # Check if creation went fine
        PrintError "Creation of ${absolutePackagePath}/debian/source/format failed because of error ${creationError}"
        return 4
    fi
    
    return 0
}

fi # FILES_FORMAT_SH

#  ______________________________ 
# |                              |
# |    ______________________    |
# |   |                      |   |
# |   |         Sign         |   |
# |   |        C0ding        |   |
# |   |        Dw@rf         |   |
# |   |         1.0          |   |
# |   |______________________|   |
# |                              |
# |______________________________|
#               |  |
#               |  |
#               |  |
#               |  |
#               |  |
#               |  |
#               |  |
#               |  |
#               |  |
#               |  |
#               |__|
