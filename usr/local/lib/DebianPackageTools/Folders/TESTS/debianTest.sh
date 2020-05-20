#!/bin/bash

# @Folder debianTest.sh
# @author SignC0dingDw@rf
# @version 1.0
# @date 20 May 2020
# @brief Unit testing of debian.sh file.

### Exit Code
#
# 0 
#

###
# MIT License
#
# Copyright (c) 2020 SignC0dingDw@rf
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation Folders (the "Software"), to deal
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

SCRIPT_LOCATION_DEBIAN_TEST_SH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
TESTED_FILE="${SCRIPT_LOCATION_DEBIAN_TEST_SH}/../debian.sh"

. "${BASH_UTILS_LIB}/BashDwfUnit/TestSuite/testsManagement.sh"
. "${BASH_UTILS_LIB}/BashDwfUnit/Assert/files.sh"
. "${BASH_UTILS_LIB}/BashDwfUnit/Assert/folders.sh"
. "${BASH_UTILS_LIB}/BashDwfUnit/Assert/functions.sh"
. "${BASH_UTILS_LIB}/BashDwfUnit/Assert/inclusions.sh"
. "${BASH_UTILS_LIB}/BashDwfUnit/Setup/declareDeletion.sh"

################################################################################
###                                                                          ###
###                                Test Suite                                ###
###                                                                          ###
################################################################################
DeclareTestSuite "Folders debian.sh tests"

################################################################################
###                                                                          ###
###                                  Setup                                   ###
###                                                                          ###
################################################################################
TestSetup()
{
    # Location to test folder
    originalPath=$(pwd)
    cd /tmp # Force root

    # Test folders
    DeclMkFoldersToDel /tmp/foo1 /tmp/foo2 /tmp/foo3
    DeclMkFoldersToDel /tmp/foo1/debian
    
    # Test files
    DeclMkFilesToDel /tmp/foo3/debian
    
    # Commands outputs
    DeclMkFilesToDel /tmp/barError /tmp/barErrorRef /tmp/barOutput /tmp/barRef
    
    return 0
}

################################################################################
###                                                                          ###
###                                 Cleanup                                  ###
###                                                                          ###
################################################################################
TestTeardown()
{
    # Back to original location
    cd ${originalPath}
    
    return 0
}

################################################################################
###                                                                          ###
###                       Tests : ContainsDebianFolder                       ###
###                                                                          ###
################################################################################
##!
# @brief Check ContainsDebianFolder behavior if no argument is provided
# @return 0 if behavior is as expected, exit 1 otherwise
#
## 
testContainsDebianFolderNoArg()
{
    INCLUDE_AND_ASSERT_VERSION "${TESTED_FILE}" "1.0"

    ContainsDebianFolder 2> /tmp/barErrorOutput > /tmp/barOutput
    ASSERT_RETURN_CODE_VALUE "1" "ContainsDebianFolder with no argument should return code 1"

    printf "" > /tmp/barRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barRef" "/tmp/barOutput"
    
    printf "" > /tmp/barErrorRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barErrorRef" "/tmp/barErrorOutput"
}

##!
# @brief Check ContainsDebianFolder behavior with an empty argument provided
# @return 0 if behavior is as expected, exit 1 otherwise
#
## 
testContainsDebianFolderEmptyArg()
{
    INCLUDE_AND_ASSERT_VERSION "${TESTED_FILE}" "1.0"

    ContainsDebianFolder "" 2> /tmp/barErrorOutput > /tmp/barOutput
    ASSERT_RETURN_CODE_VALUE "1" "ContainsDebianFolder with empty argument should return code 1"

    printf "" > /tmp/barRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barRef" "/tmp/barOutput"
    
    printf "" > /tmp/barErrorRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barErrorRef" "/tmp/barErrorOutput"
}

##!
# @brief Check ContainsDebianFolder behavior with provided path that does not exist
# @return 0 if behavior is as expected, exit 1 otherwise
#
## 
testContainsDebianFolderPathNotExisting()
{
    INCLUDE_AND_ASSERT_VERSION "${TESTED_FILE}" "1.0"

    ContainsDebianFolder "doNotExist" 2> /tmp/barErrorOutput > /tmp/barOutput
    ASSERT_RETURN_CODE_VALUE "1" "ContainsDebianFolder with path not existing should return code 1"

    printf "" > /tmp/barRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barRef" "/tmp/barOutput"
    
    printf "" > /tmp/barErrorRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barErrorRef" "/tmp/barErrorOutput"
}

##!
# @brief Check ContainsDebianFolder behavior with a path containing debian folder
# @return 0 if behavior is as expected, exit 1 otherwise
#
## 
testContainsDebianFolderOK()
{
    INCLUDE_AND_ASSERT_VERSION "${TESTED_FILE}" "1.0"

    ContainsDebianFolder "/tmp/foo1" 2> /tmp/barErrorOutput > /tmp/barOutput
    ASSERT_RETURN_CODE_VALUE "0" "ContainsDebianFolder with path containing debian folder should return code 0"

    printf "" > /tmp/barRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barRef" "/tmp/barOutput"
    
    printf "" > /tmp/barErrorRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barErrorRef" "/tmp/barErrorOutput"
}

##!
# @brief Check ContainsDebianFolder behavior with a path not containing debian folder
# @return 0 if behavior is as expected, exit 1 otherwise
#
## 
testContainsDebianFolderKO()
{
    INCLUDE_AND_ASSERT_VERSION "${TESTED_FILE}" "1.0"

    ContainsDebianFolder "foo2" 2> /tmp/barErrorOutput > /tmp/barOutput
    ASSERT_RETURN_CODE_VALUE "1" "ContainsDebianFolder with path not containing debian folder should return code 1"

    printf "" > /tmp/barRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barRef" "/tmp/barOutput"
    
    printf "" > /tmp/barErrorRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barErrorRef" "/tmp/barErrorOutput"
}

##!
# @brief Check ContainsDebianFolder behavior with a path containing debian file
# @return 0 if behavior is as expected, exit 1 otherwise
#
## 
testContainsDebianFolderDebianFile()
{
    INCLUDE_AND_ASSERT_VERSION "${TESTED_FILE}" "1.0"

    ContainsDebianFolder "/tmp/foo3" 2> /tmp/barErrorOutput > /tmp/barOutput
    ASSERT_RETURN_CODE_VALUE "1" "ContainsDebianFolder with path containing debian file should return code 1"

    printf "" > /tmp/barRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barRef" "/tmp/barOutput"
    
    printf "" > /tmp/barErrorRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barErrorRef" "/tmp/barErrorOutput"
}

AddTests "testContainsDebianFolderNoArg" "testContainsDebianFolderEmptyArg" "testContainsDebianFolderPathNotExisting" "testContainsDebianFolderOK" "testContainsDebianFolderKO" "testContainsDebianFolderDebianFile"

################################################################################
###                                                                          ###
###                         Tests : InitDebianFolder                         ###
###                                                                          ###
################################################################################
##!
# @brief Check InitDebianFolder behavior if no argument is provided
# @return 0 if behavior is as expected, exit 1 otherwise
#
## 
testInitDebianFolderNoArg()
{
    INCLUDE_AND_ASSERT_VERSION "${TESTED_FILE}" "1.0"

    InitDebianFolder 2> /tmp/barErrorOutput > /tmp/barOutput
    ASSERT_RETURN_CODE_VALUE "2" "InitDebianFolder with no argument should return code 2"

    printf "" > /tmp/barRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barRef" "/tmp/barOutput"

    printf "[Error] : Path  does not exist\n" > /tmp/barErrorRef    
    printf "[Error] : Failed to convert path  to absolute path because of error 1\n" >> /tmp/barErrorRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barErrorRef" "/tmp/barErrorOutput"
}

##!
# @brief Check InitDebianFolder behavior with empty argument provided
# @return 0 if behavior is as expected, exit 1 otherwise
#
## 
testInitDebianFolderEmptyArg()
{
    INCLUDE_AND_ASSERT_VERSION "${TESTED_FILE}" "1.0"

    InitDebianFolder "" 2> /tmp/barErrorOutput > /tmp/barOutput
    ASSERT_RETURN_CODE_VALUE "2" "InitDebianFolder with empty argument should return code 2"

    printf "" > /tmp/barRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barRef" "/tmp/barOutput"

    printf "[Error] : Path  does not exist\n" > /tmp/barErrorRef    
    printf "[Error] : Failed to convert path  to absolute path because of error 1\n" >> /tmp/barErrorRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barErrorRef" "/tmp/barErrorOutput"
}

##!
# @brief Check InitDebianFolder behavior with argument being path not existing
# @return 0 if behavior is as expected, exit 1 otherwise
#
## 
testInitDebianFolderPathNotExisting()
{
    INCLUDE_AND_ASSERT_VERSION "${TESTED_FILE}" "1.0"

    InitDebianFolder "titi/../tutu" 2> /tmp/barErrorOutput > /tmp/barOutput
    ASSERT_RETURN_CODE_VALUE "2" "InitDebianFolder with argument being path not existing should return code 2"

    printf "" > /tmp/barRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barRef" "/tmp/barOutput"

    printf "[Error] : Path titi/../tutu does not exist\n" > /tmp/barErrorRef    
    printf "[Error] : Failed to convert path titi/../tutu to absolute path because of error 1\n" >> /tmp/barErrorRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barErrorRef" "/tmp/barErrorOutput"
}

##!
# @brief Check InitDebianFolder behavior with argument being path containing debian folder
# @return 0 if behavior is as expected, exit 1 otherwise
#
## 
testInitDebianFolderPathWithDebianFolder()
{
    INCLUDE_AND_ASSERT_VERSION "${TESTED_FILE}" "1.0"

    InitDebianFolder "foo1" 2> /tmp/barErrorOutput > /tmp/barOutput
    ASSERT_RETURN_CODE_VALUE "1" "InitDebianFolder with path containing debian folder should return code 1"

    printf "" > /tmp/barRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barRef" "/tmp/barOutput"

    printf "[Error] : Folder /tmp/foo1 already contains debian folder. Aborting\n" > /tmp/barErrorRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barErrorRef" "/tmp/barErrorOutput"
}

##!
# @brief Check InitDebianFolder behavior with argument being path containing debian file
# @return 0 if behavior is as expected, exit 1 otherwise
#
## 
testInitDebianFolderPathWithDebianFile()
{
    INCLUDE_AND_ASSERT_VERSION "${TESTED_FILE}" "1.0"

    InitDebianFolder "/tmp/foo3" 2> /tmp/barErrorOutput > /tmp/barOutput
    ASSERT_RETURN_CODE_VALUE "3" "InitDebianFolder with path containing debian file should return code 3"

    printf "" > /tmp/barRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barRef" "/tmp/barOutput"

    printf "mkdir: cannot create directory '/tmp/foo3/debian': File exists\n" > /tmp/barErrorRef
    printf "[Error] : Creation of /tmp/foo3/debian failed because of error 1\n" >> /tmp/barErrorRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barErrorRef" "/tmp/barErrorOutput"
}

##!
# @brief Check InitDebianFolder behavior with argument being path not containing debian folder
# @return 0 if behavior is as expected, exit 1 otherwise
#
## 
testInitDebianFolderPathWithoutDebianFolder()
{
    INCLUDE_AND_ASSERT_VERSION "${TESTED_FILE}" "1.0"

    InitDebianFolder "foo2" 2> /tmp/barErrorOutput > /tmp/barOutput
    ASSERT_RETURN_CODE_VALUE "0" "InitDebianFolder with path not containing debian folder should return code 0"

    printf "" > /tmp/barRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barRef" "/tmp/barOutput"

    printf "" > /tmp/barErrorRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barErrorRef" "/tmp/barErrorOutput"
    
    # Check folder content
    local foo2Content=("debian")  
    ASSERT_FOLDER_HAS_EXPECTED_CONTENT "foo2Content" "/tmp/foo2" "Folder /tmp/foo2 should contain only debian folder."
}

AddTests "testInitDebianFolderNoArg" "testInitDebianFolderEmptyArg" "testInitDebianFolderPathNotExisting" "testInitDebianFolderPathWithDebianFolder" "testInitDebianFolderPathWithDebianFile" "testInitDebianFolderPathWithoutDebianFolder"

################################################################################
###                                                                          ###
###                              Execute Tests                               ###
###                                                                          ###
################################################################################
RunAllTests

################################################################################
###                                                                          ###
###                             Display Results                              ###
###                                                                          ###
################################################################################
DisplayTestSuiteExeSummary

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
