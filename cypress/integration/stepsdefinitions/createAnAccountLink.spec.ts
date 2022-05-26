import {Given,  When, Then } from "cypress-cucumber-preprocessor/steps";
import LogInPage from "../../pageObjects/LogInPage";

const logInPage: LogInPage = new LogInPage();

Given('the user is on the Login page', () => {
    logInPage.visit()
    cy.contains('Log In').should('be.visible')
})

When('the user tries to enter the registration form via the {string} link', (linkName) => {
    cy.contains(linkName).click()
})

Then('the user should be redirected to the Register page', () => {
    cy.contains('First name').should('be.visible')
})