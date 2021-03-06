Feature: Create task
  In order to stay on top of my tasks
  As a user
  I need to create a new task

  Background:
    Given there are 3 tasks

  Scenario: Create a valid task
    When the client submits a POST request to /tasks with:
      """json
      { "title":"Water the plants" }
      """
    Then a new task should be created with the following attributes:
      | title            | status | deadline | priority | description |
      | Water the plants | new    | nil      | normal   | nil         |
    And the response should indicate the task was saved successfully

  Scenario: Attempt to create an invalid task
    When the client submits a POST request to /tasks with:
      """json
      { "status":"new" }
      """
    Then no task should be created
    And the response should indicate the task was not saved successfully