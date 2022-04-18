Feature: Password Reset

    I want to change my forgotten password

    # Background:
    #     Given the user is on the Landing page
    #     * the user clicks on "Log-in" button
    #     * the user is on the Login page

    # @focus
    Scenario: User forgot his password and wants to recover it
        Given the user is on the Login page
        # When the user clicks on "Log-in" button
        Then the user should see "Forgot password?" in the link

    # @focus
    Scenario: User clicks forgot password link
        Given the user is on the Login page
        When the user clicks on the "Forgot password?" link
        Then the user should see "Please, type your email:" in the pop-up

    @skip
    Scenario Outline: User forgot their password
        Given the user is on the Login page
        When the user clicks on "forgot password?" link
        Then the user should see "Please, type your email:" in the pop-up
        And the following elements should be displayed:
            | Element name   | Type   | is mandatory? | Status   |
            | Recovery label | Text   |               |          |
            | Recovery email | Input  | Yes           | Enabled  |
            | Submit         | Button |               | Disabled |

    @skip
    Scenario Outline: User fills recovery email form
        Given the user is on the "Email confirmation" page
        When the user fills in the <recovery email> field
        And clicks the <Submit> button
        Then an email containing the recovery link is sent to the user
            | Element name   | Type   | is mandatory? | Status   |
            | Recovery label | Text   |               |          |
            | Recovery email | Input  | Yes           | Enabled  |
            | Submit         | Button |               | Disabled |


    @skip
    Scenario Outline: User receives recovery email
        Given a link was sent to the user
        When the user clicks on the link
        Then the user should be redirected to the "Set up new password" page
        And the following elements should be displayed:
            | Element name         | Type   | is mandatory? | Status   |
            | New password         | Input  | Yes           | Enabled  |
            | Confirm new password | Input  | Yes           | Enabled  |
            | Submit               | Button |               | Disabled |

    @skip
    Scenario Outline: User sets new password
        Given the user is in the "Set up a new password page"
        When the user fills in the <New password> field
        * fills in the <Confirm password> field
        * clicks on the <Submit> button
        Then a <Success message> is shown to the user
            | Element name         | Type   | is mandatory? | Status   | Value                       |
            | New password         | Input  | Yes           | Enabled  |                             |
            | Confirm new password | Input  | Yes           | Enabled  |                             |
            | Submit               | Button |               | Disabled |                             |
            | Success message      | Text   |               | Visible  | The password has been reset |

    @skip
    Scenario Outline: User fills in incorrect email
        Given user is on the "Email confirmation page"
        When user fills in the <recovery email> field
        But the email format is incorrect
        And clicks <Submit> button
        Then an <Error message> is shown to the user
            | Element name   | Type   | is mandatory? | Status   | Value                      |
            | Recovery email | Input  | Yes           | Enabled  |                            |
            | Submit         | Button |               | Disabled |                            |
            | Error message  | Text   |               | Visible  | Please enter a valid email |

    @skip
    Scenario Outline: User leaves email field empty
        Given user is on the "Email confirmation page"
        When user leaves <recovery email> field empty
        And clicks <Submit> button
        Then an <Error message> is shown to the user
            | Element name   | Type   | is mandatory? | Status   | Value                      |
            | Recovery email | Input  | Yes           | Enabled  |                            |
            | Submit         | Button |               | Disabled |                            |
            | Error message  | Text   |               | Visible  | This field cannot be empty |

    @skip
    Scenario Outline: User enters new password and it doesn't meet the security requirements
        Given the user is in the "Set up a new password page"
        When the user fills in the <New password> field
        And fills in the <Confirm password> field
        But <New password> field does not meet the password security requirements
        And clicks on the <Submit> button
        Then a <Error message> is shown to the user
            | Element name         | Type   | is mandatory? | Status   | Value                                              |
            | New password         | Input  | Yes           | Enabled  |                                                    |
            | Confirm new password | Input  | Yes           | Enabled  |                                                    |
            | Submit               | Button |               | Disabled |                                                    |
            | Error message        | Text   |               | Visible  | The password must follow the next requirements:... |

    @skip
    Scenario Outline: User entered the new password and it's the same as the old one
        Given the user is in the "Set up a new password page"
        When the user fills in the <New password> field
        And fills in the <Confirm password> field
        But <New password> is the same as the user's "old password"
        And clicks on the <Submit> button
        Then a <Error message> is shown to the user
            | Element name         | Type   | is mandatory? | Status   | Value                                          |
            | New password         | Input  | Yes           | Enabled  |                                                |
            | Confirm new password | Input  | Yes           | Enabled  |                                                |
            | Submit               | Button |               | Disabled |                                                |
            | Error message        | Text   |               | Visible  | New password cannot be the same as the old one |

    @skip
    Scenario Outline: User leaves 1 or more fields empty on set up new password page
        Given the user is in the "Set up a new password page"
        When the user leaves the <New password> or <Confirm password> field(s) empty
        And clicks on the <Submit> button
        Then a <Error message> is shown to the user
            | Element name         | Type   | is mandatory? | Status   | Value                        |
            | New password         | Input  | Yes           | Enabled  |                              |
            | Confirm new password | Input  | Yes           | Enabled  |                              |
            | Submit               | Button |               | Disabled |                              |
            | Error message        | Text   |               | Visible  | All fields must be filled in |

    @skip
    Scenario Outline: User entered a different password in new and confirm password fields
        Given the user is in the "Set up a new password page"
        When the user fills in the <New password> field
        And fills in the <Confirm password> field
        But <Confirm password> field doesn't match with <New password> field
        And clicks on the <Submit> button
        Then a <Error message> is shown to the user
            | Element name         | Type   | is mandatory? | Status   | Value                                          |
            | New password         | Input  | Yes           | Enabled  |                                                |
            | Confirm new password | Input  | Yes           | Enabled  |                                                |
            | Submit               | Button |               | Disabled |                                                |
            | Error message        | Text   |               | Visible  | Confirm password and new password should match |