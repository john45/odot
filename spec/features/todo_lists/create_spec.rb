require 'rails_helper'

describe 'Create todo list' do

  def create_todolist(options={})
    options[:title] ||= 'My todolist'
    options[:body] ||= 'This is my todo list!'

    visit "/todo_lists"
    click_link "New Todo List"
    expect(page).to have_content("New Todo List")

    fill_in "Title", with: options[:title]
    fill_in "Body", with: options[:body]
    click_button "Create Todo list"
  end

  it 'Redirect to index file on success' do
    create_todolist

    expect(page).to have_content("My todolist")
  end

  it "have display error when todolist has no title " do
    expect(TodoList.count).to eq(0)

    create_todolist title: ""

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("This is what aim todo today!")

  end

  it "have display error when todolist a title less 3 characters " do
    expect(TodoList.count).to eq(0)

   create_todolist title: "hi", body: "This is what aim todo today!"

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("This is what aim todo today!")

  end

  it "have display error when todolist no body " do
    expect(TodoList.count).to eq(0)

    create_todolist title: "Grocery list", body: ""

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("Grocery list")

  end

  it "have display error when todolist less 5 characters" do
    expect(TodoList.count).to eq(0)

    create_todolist title: "Grocery list", body: "body"

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("Grocery list")

  end
end