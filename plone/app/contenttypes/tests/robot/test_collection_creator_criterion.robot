*** Settings ***

Resource  plone/app/robotframework/keywords.robot
Resource  plone/app/contenttypes/tests/robot/keywords.txt

Test Setup  Run keywords  Open test browser
Test Teardown  Close all browsers

*** Test cases ***

Scenario: Test Creator Criterion
    Given a site owner document  Site Owner Document
      And a test user document  Test User Document
      And a collection  My Collection
     When I set the collection's creator criterion to  ${TEST_USER_ID}
     Then the collection should contain  Test User Document
      And the collection should not contain  Site Owner Document


*** Keywords ***

a site owner document
    [Arguments]  ${title}
    Log in as site owner
    a document  ${title}

a test user document
    [Arguments]  ${title}
    Log in as test user
    a document  ${title}
    Log out
    Log in as site owner

Click ${name} In Edit Bar
    Page Should Contain Element  id=edit-bar  Edit bar is not available : edit permission missing ?
    Element Should Contain  css=#edit-bar  ${name}
    Click Link  ${name}

I select criteria ${type} in row ${number} ${label}
  ${criteria_row} =  Convert to String  .querystring-criteria-wrapper:nth-child(${number})
  Wait until page contains Element  css=${criteria_row} .querystring-criteria-${type} .select2-choice
  Pause
  Click Element  css=${criteria_row} .querystring-criteria-${type} .select2-choice
  Pause
  Wait until page contains Element  css=.select2-input
  Pause
  Input Text  css=.select2-input  ${label}
  Pause
  Click Element  xpath=//li[//span[@class='select2-match'][text()='${label}']]


I set the collection's creator criterion to
    [Arguments]  ${criterion}
    Click Edit

    I select criteria index in row 1 Creator
    I select criteria operator in row 1 Is
    #Input Text  name=form.widgets.ICollection.query.v:records  ${criterion}

    Click Button  Save
    Wait until page contains  Changes saved
