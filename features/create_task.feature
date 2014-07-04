Feature: Create task
  In order to stay on top of my tasks
  As a user
  I need to create a new task

  Scenario: Create a valid task
    When the client submits a POST request to /tasks with:
      """json
      { "title":"Water the plants" }
      """
    Then a new task should be created with the title 'Water the plants'
    And the response should indicate the task was saved successfully

  Scenario: Attempt to create an invalid task
    When the client submits a POST request to /tasks with:
      """json
      { "complete":false }
      """
    Then no task should be created
    And the response should indicate the task was not saved successfully