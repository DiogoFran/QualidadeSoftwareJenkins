Feature: Botao só aparece quando a lista está vazia
As a user 
I want to be able to mock todo items
So that I can see the list of todos filled in with 10 randomly generated items

Background:App open
    Given the user open the application

  Scenario: Todo List automatically filled in
    And the todo list is empty
    When the user clicks on the "GetRandomData" button
    Then the todo list gets 10 new items
    And the "Get Random Data" button disappears

  Scenario: todo list already has items and button is not available
    And the todo list has one item
    Then the user clicks on the "Get Random Data" between is not available
    And the todo list keeps itss original comtent
