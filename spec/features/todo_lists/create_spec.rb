require 'rails_helper'

describe 'Create todo list' do

  it 'Redirect to index file on success' do
    visit "/todo_lists"
    click_link "New Todo List"
    expect(page).to have_content("New Todo List")

    fill_in "Title", with: "My todolist"
    fill_in "Body", with: "This is what aim todo today!"
    click_button "Create Todo list"

    expect(page).to have_content("My todolist")
  end

  it "have display error when todolist has no title " do
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    click_link "New Todo List"
    expect(page).to have_content("New Todo List")

    fill_in "Title", with: ""
    fill_in "Body", with: "This is what aim todo today!"
    click_button "Create Todo list"

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("This is what aim todo today!")

  end

  it "have display error when todolist a title less 3 characters " do
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    click_link "New Todo List"
    expect(page).to have_content("New Todo List")

    fill_in "Title", with: "Hi"
    fill_in "Body", with: "This is what aim todo today!"
    click_button "Create Todo list"

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("This is what aim todo today!")

  end

  it "have display error when todolist no body " do
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    click_link "New Todo List"
    expect(page).to have_content("New Todo List")

    fill_in "Title", with: "Grocery list"
    fill_in "Body", with: ""
    click_button "Create Todo list"

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("Grocery list")

  end

  it "have display error when todolist less 5 characters" do
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    click_link "New Todo List"
    expect(page).to have_content("New Todo List")

    fill_in "Title", with: "Grocery list"
    fill_in "Body", with: "body"
    click_button "Create Todo list"

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("Grocery list")

  end
end