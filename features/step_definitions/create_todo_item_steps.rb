Given /^I am a user$/ do
  @user = FactoryGirl.create(:user)
  @user_todo_items_count = @user.todo_items.count 
end

When /^I navigate to my new to-do item page$/ do
  visit new_user_todo_item_path(@user.id)
end

When /^I submit the filled-out form$/ do 
  fill_in('Title', {with: "My To-Do Item"})
  fill_in('Description', {with: "Test to-do items with Cucumber & Capybara"})
  choose('todo_item_priority_urgent')
  select('Blocking', {from: 'todo_item_status'})
  click_button('Create Todo item')
end

When /^I submit the form with no title$/ do 
  fill_in('Description', {with: "Test to-do items with Cucumber & Capybara"})
  choose('todo_item_priority_urgent')
  select('Blocking', {from: 'todo_item_status'})
  click_button('Create Todo item')
end

When /^I submit the form with only a title$/ do 
  fill_in('Title', {with: "Take out the trash"})
  click_button('Create Todo item')
end

Then /^a to-do item should be created$/ do 
  TodoItems.count.should eql(@user_todo_items_count + 1)
end

Then /^I should see a message that the to-do item was created$/ do 
  find('#notice').should have_content("Todo item was successfully created")
end