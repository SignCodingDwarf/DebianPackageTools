#!/bin/bash

# @Folder formatTest.sh
# @author SignC0dingDw@rf
# @version 1.0
# @date 25 May 2020
# @brief Unit testing of format.sh file.

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

SCRIPT_LOCATION_FORMAT_TEST_SH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
TESTED_FILE="${SCRIPT_LOCATION_FORMAT_TEST_SH}/../format.sh"

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
DeclareTestSuite "Folders format.sh tests"

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
    DeclMkFoldersToDel /tmp/foo1 /tmp/foo2 /tmp/foo3 /tmp/foo4 /tmp/foo5
    DeclMkFoldersToDel /tmp/foo1/debian /tmp/foo2/debian /tmp/foo3/debian /tmp/foo4/debian 
    DeclMkFoldersToDel /tmp/foo1/debian/source /tmp/foo2/debian/source /tmp/foo3/debian/source
    DeclMkFoldersToDel /tmp/foo2/debian/source/format
    
    # Test files
    DeclMkFilesToDel /tmp/foo1/debian/source/format
    
    # Reference files
    DeclMkFilesToDel /tmp/formatRef
    printf "3.0 (native)" > /tmp/formatRef
    
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
###                        Tests : ContainsFormatFile                        ###
###                                                                          ###
################################################################################
##!
# @brief Check ContainsFormatFile behavior if no argument is provided
# @return 0 if behavior is as expected, exit 1 otherwise
#
## 
testContainsFormatFileNoArg()
{
    INCLUDE_AND_ASSERT_VERSION "${TESTED_FILE}" "1.0"

    ContainsFormatFile 2> /tmp/barErrorOutput > /tmp/barOutput
    ASSERT_RETURN_CODE_VALUE "1" "ContainsFormatFile with no argument should return code 1"

    printf "" > /tmp/barRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barRef" "/tmp/barOutput"
    
    printf "" > /tmp/barErrorRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barErrorRef" "/tmp/barErrorOutput"
}

##!
# @brief Check ContainsFormatFile behavior with an empty argument provided
# @return 0 if behavior is as expected, exit 1 otherwise
#
## 
testContainsFormatFileEmptyArg()
{
    INCLUDE_AND_ASSERT_VERSION "${TESTED_FILE}" "1.0"

    ContainsFormatFile "" 2> /tmp/barErrorOutput > /tmp/barOutput
    ASSERT_RETURN_CODE_VALUE "1" "ContainsFormatFile with empty argument should return code 1"

    printf "" > /tmp/barRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barRef" "/tmp/barOutput"
    
    printf "" > /tmp/barErrorRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barErrorRef" "/tmp/barErrorOutput"
}

##!
# @brief Check ContainsFormatFile behavior with provided path that does not exist
# @return 0 if behavior is as expected, exit 1 otherwise
#
## 
testContainsFormatFilePathNotExisting()
{
    INCLUDE_AND_ASSERT_VERSION "${TESTED_FILE}" "1.0"

    ContainsFormatFile "doNotExist" 2> /tmp/barErrorOutput > /tmp/barOutput
    ASSERT_RETURN_CODE_VALUE "1" "ContainsFormatFile with path not existing should return code 1"

    printf "" > /tmp/barRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barRef" "/tmp/barOutput"
    
    printf "" > /tmp/barErrorRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barErrorRef" "/tmp/barErrorOutput"
}

##!
# @brief Check ContainsFormatFile behavior with a path containing debian/source/format file
# @return 0 if behavior is as expected, exit 1 otherwise
#
## 
testContainsFormatFileOK()
{
    INCLUDE_AND_ASSERT_VERSION "${TESTED_FILE}" "1.0"

    ContainsFormatFile "/tmp/foo1" 2> /tmp/barErrorOutput > /tmp/barOutput
    ASSERT_RETURN_CODE_VALUE "0" "ContainsFormatFile with path containing debian/source/format file should return code 0"

    printf "" > /tmp/barRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barRef" "/tmp/barOutput"
    
    printf "" > /tmp/barErrorRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barErrorRef" "/tmp/barErrorOutput"
}

##!
# @brief Check ContainsFormatFile behavior with a path containing debian/source/format folder
# @return 0 if behavior is as expected, exit 1 otherwise
#
## 
testContainsFormatFileFomatFolder()
{
    INCLUDE_AND_ASSERT_VERSION "${TESTED_FILE}" "1.0"

    ContainsFormatFile "/tmp/foo2" 2> /tmp/barErrorOutput > /tmp/barOutput
    ASSERT_RETURN_CODE_VALUE "1" "ContainsFormatFile with path containing debian/source/format folder should return code 1"

    printf "" > /tmp/barRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barRef" "/tmp/barOutput"
    
    printf "" > /tmp/barErrorRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barErrorRef" "/tmp/barErrorOutput"
}


##!
# @brief Check ContainsFormatFile behavior with a path not containing debian/source/format file
# @return 0 if behavior is as expected, exit 1 otherwise
#
## 
testContainsFormatFileKOFormat()
{
    INCLUDE_AND_ASSERT_VERSION "${TESTED_FILE}" "1.0"

    ContainsFormatFile "foo3" 2> /tmp/barErrorOutput > /tmp/barOutput
    ASSERT_RETURN_CODE_VALUE "1" "ContainsFormatFile with path not containing debian/source/format file should return code 1"

    printf "" > /tmp/barRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barRef" "/tmp/barOutput"
    
    printf "" > /tmp/barErrorRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barErrorRef" "/tmp/barErrorOutput"
}

##!
# @brief Check ContainsFormatFile behavior with a path not containing debian/source folder
# @return 0 if behavior is as expected, exit 1 otherwise
#
## 
testContainsFormatFileKOSource()
{
    INCLUDE_AND_ASSERT_VERSION "${TESTED_FILE}" "1.0"

    ContainsFormatFile "./foo4" 2> /tmp/barErrorOutput > /tmp/barOutput
    ASSERT_RETURN_CODE_VALUE "1" "ContainsFormatFile with path not containing debian/source folder should return code 1"

    printf "" > /tmp/barRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barRef" "/tmp/barOutput"
    
    printf "" > /tmp/barErrorRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barErrorRef" "/tmp/barErrorOutput"
}

##!
# @brief Check ContainsFormatFile behavior with a path not containing debian folder
# @return 0 if behavior is as expected, exit 1 otherwise
#
## 
testContainsFormatFileKODebian()
{
    INCLUDE_AND_ASSERT_VERSION "${TESTED_FILE}" "1.0"

    ContainsFormatFile "/tmp/foo5" 2> /tmp/barErrorOutput > /tmp/barOutput
    ASSERT_RETURN_CODE_VALUE "1" "ContainsFormatFile with path not containing debian folder should return code 1"

    printf "" > /tmp/barRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barRef" "/tmp/barOutput"
    
    printf "" > /tmp/barErrorRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barErrorRef" "/tmp/barErrorOutput"
}

AddTests "testContainsFormatFileNoArg" "testContainsFormatFileEmptyArg" "testContainsFormatFilePathNotExisting" "testContainsFormatFileOK" "testContainsFormatFileFomatFolder" "testContainsFormatFileKOFormat"  "testContainsFormatFileKOSource" "testContainsFormatFileKODebian" 

################################################################################
###                                                                          ###
###                       Tests : DefaultFormatContent                       ###
###                                                                          ###
################################################################################
##!
# @brief Check DefaultFormatContent behavior 
# @return 0 if behavior is as expected, exit 1 otherwise
#
## 
testDefaultFormatContent()
{
    INCLUDE_AND_ASSERT_VERSION "${TESTED_FILE}" "1.0"

    DefaultFormatContent 2> /tmp/barErrorOutput > /tmp/barOutput
    ASSERT_RETURN_CODE_VALUE "0" "DefaultFormatContent should return code 0"

    ASSERT_FILES_ARE_IDENTICAL "/tmp/formatRef" "/tmp/barOutput"
    
    printf "" > /tmp/barErrorRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barErrorRef" "/tmp/barErrorOutput"
}

AddTests "testDefaultFormatContent"

################################################################################
###                                                                          ###
###                          Tests : InitFormatFile                          ###
###                                                                          ###
################################################################################
##!
# @brief Check InitFormatFile behavior if no argument is provided
# @return 0 if behavior is as expected, exit 1 otherwise
#
## 
testInitFormatFileNoArg()
{
    INCLUDE_AND_ASSERT_VERSION "${TESTED_FILE}" "1.0"

    InitFormatFile 2> /tmp/barErrorOutput > /tmp/barOutput
    ASSERT_RETURN_CODE_VALUE "3" "InitFormatFile with no argument should return code 3"

    printf "" > /tmp/barRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barRef" "/tmp/barOutput"

    printf "[Error] : Path  does not exist\n" > /tmp/barErrorRef    
    printf "[Error] : Failed to convert path  to absolute path because of error 1\n" >> /tmp/barErrorRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barErrorRef" "/tmp/barErrorOutput"
}

##!
# @brief Check InitFormatFile behavior with empty argument provided
# @return 0 if behavior is as expected, exit 1 otherwise
#
## 
testInitFormatFileEmptyArg()
{
    INCLUDE_AND_ASSERT_VERSION "${TESTED_FILE}" "1.0"

    InitFormatFile "" 2> /tmp/barErrorOutput > /tmp/barOutput
    ASSERT_RETURN_CODE_VALUE "3" "InitFormatFile with empty argument should return code 3"

    printf "" > /tmp/barRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barRef" "/tmp/barOutput"

    printf "[Error] : Path  does not exist\n" > /tmp/barErrorRef    
    printf "[Error] : Failed to convert path  to absolute path because of error 1\n" >> /tmp/barErrorRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barErrorRef" "/tmp/barErrorOutput"
}

##!
# @brief Check InitFormatFile behavior with argument being path not existing
# @return 0 if behavior is as expected, exit 1 otherwise
#
## 
testInitFormatFilePathNotExisting()
{
    INCLUDE_AND_ASSERT_VERSION "${TESTED_FILE}" "1.0"

    InitFormatFile "OutFromAsgard/Valhalla" 2> /tmp/barErrorOutput > /tmp/barOutput
    ASSERT_RETURN_CODE_VALUE "3" "InitFormatFile with path not existing should return code 3"

    printf "" > /tmp/barRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barRef" "/tmp/barOutput"

    printf "[Error] : Path OutFromAsgard/Valhalla does not exist\n" > /tmp/barErrorRef    
    printf "[Error] : Failed to convert path OutFromAsgard/Valhalla to absolute path because of error 1\n" >> /tmp/barErrorRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barErrorRef" "/tmp/barErrorOutput"
}

##!
# @brief Check InitFormatFile behavior with argument being path without debian folder
# @return 0 if behavior is as expected, exit 1 otherwise
#
## 
testInitFormatFilePathWithoutDebianFolder()
{
    INCLUDE_AND_ASSERT_VERSION "${TESTED_FILE}" "1.0"

    InitFormatFile "foo5" 2> /tmp/barErrorOutput > /tmp/barOutput
    ASSERT_RETURN_CODE_VALUE "2" "InitFormatFile with argument missing not containing debian folder should return code 2"

    printf "" > /tmp/barRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barRef" "/tmp/barOutput"
 
    printf "[Error] : Folder /tmp/foo5 does not contain debian/source folder.\n" > /tmp/barErrorRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barErrorRef" "/tmp/barErrorOutput"
}

##!
# @brief Check InitFormatFile behavior with argument being path without source folder
# @return 0 if behavior is as expected, exit 1 otherwise
#
## 
testInitFormatFilePathWithoutSourceFolder()
{
    INCLUDE_AND_ASSERT_VERSION "${TESTED_FILE}" "1.0"

    InitFormatFile "/tmp/foo4" 2> /tmp/barErrorOutput > /tmp/barOutput
    ASSERT_RETURN_CODE_VALUE "2" "InitFormatFile with argument missing not containing debian/source folder should return code 2"

    printf "" > /tmp/barRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barRef" "/tmp/barOutput"
 
    printf "[Error] : Folder /tmp/foo4 does not contain debian/source folder.\n" > /tmp/barErrorRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barErrorRef" "/tmp/barErrorOutput"
}

##!
# @brief Check InitFormatFile behavior with argument being path containing debian/source/format file
# @return 0 if behavior is as expected, exit 1 otherwise
#
## 
testInitFormatFilePathWithFormatFile()
{
    INCLUDE_AND_ASSERT_VERSION "${TESTED_FILE}" "1.0"

    InitFormatFile "/tmp/foo1" 2> /tmp/barErrorOutput > /tmp/barOutput
    ASSERT_RETURN_CODE_VALUE "1" "InitFormatFile with argument rgument being path containing debian/source/format file should return code 1"

    printf "" > /tmp/barRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barRef" "/tmp/barOutput"
 
    printf "[Error] : Folder /tmp/foo1/debian/source already contains format file. Aborting\n" > /tmp/barErrorRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barErrorRef" "/tmp/barErrorOutput"
}

##!
# @brief Check InitFormatFile behavior with argument being path containing debian/source/format folder
# @return 0 if behavior is as expected, exit 1 otherwise
#
## 
testInitFormatFilePathWithFormatFolder()
{
    INCLUDE_AND_ASSERT_VERSION "${TESTED_FILE}" "1.0"

    InitFormatFile "foo2" 2> /tmp/barErrorOutput > /tmp/barOutput
    ASSERT_RETURN_CODE_VALUE "4" "InitFormatFile with argument being path containing debian/source/format folder should return code 4"

    printf "" > /tmp/barRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barRef" "/tmp/barOutput"
 
    printf "/testFolder/usr/local/lib/DebianPackageTools/Files/TESTS/../format.sh: line 157: /tmp/foo2/debian/source/format: Is a directory\n" > /tmp/barErrorRef
    printf "[Error] : Creation of /tmp/foo2/debian/source/format failed because of error 1\n" >> /tmp/barErrorRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barErrorRef" "/tmp/barErrorOutput"
}

##!
# @brief Check InitFormatFile behavior with argument being path not containing debian/source/format file
# @return 0 if behavior is as expected, exit 1 otherwise
#
## 
testInitFormatFilePathWithoutFormatFile()
{
    INCLUDE_AND_ASSERT_VERSION "${TESTED_FILE}" "1.0"

    InitFormatFile "./foo3" 2> /tmp/barErrorOutput > /tmp/barOutput
    ASSERT_RETURN_CODE_VALUE "0" "InitFormatFile with argument being path not containing debian/source/format file should return code 0"

    printf "" > /tmp/barRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barRef" "/tmp/barOutput"
 
    printf "" > /tmp/barErrorRef
    ASSERT_FILES_ARE_IDENTICAL "/tmp/barErrorRef" "/tmp/barErrorOutput"
    
    # Check folder content
    local sourceContent=("format")  
    ASSERT_FOLDER_HAS_EXPECTED_CONTENT "sourceContent" "/tmp/foo3/debian/source" "Folder /tmp/foo3/debian/source should contain only format file."
    
    # Check file content
    ASSERT_FILES_ARE_IDENTICAL "/tmp/formatRef" "/tmp/foo3/debian/source/format"
}

AddTests "testInitFormatFileNoArg" "testInitFormatFileEmptyArg" "testInitFormatFilePathNotExisting" "testInitFormatFilePathWithoutDebianFolder" "testInitFormatFilePathWithoutSourceFolder" "testInitFormatFilePathWithFormatFile" "testInitFormatFilePathWithFormatFolder" "testInitFormatFilePathWithoutFormatFile"

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
