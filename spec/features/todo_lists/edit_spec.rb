require 'rails_helper'

describe 'Editing+ todo list' do
  let!(:todo_list) {TodoList.create(title: 'Grocery', body: 'Grocery list')}

  def update_todo_list(options={})
    options[:title] ||= "NewTitle"
    options[:body] ||= "New Description"

    todo_list = options[:todo_list]

    visit '/todo_lists'
    within "#todo_list_#{todo_list.id}" do
      click_link "Edit"
    end

    fill_in "Title", with: options[:title]
    fill_in "Body", with: options[:body]
    click_button "Update Todo list"

  end

  it 'succesfuly update information with correct date' do
    update_todo_list todo_list:todo_list,
                     title: "NewTitle",
                     body: "New Description"

    todo_list.reload

    expect(page).to have_content("Todo list was successfully updated.")
    expect(todo_list.title).to eq("NewTitle")
    expect(todo_list.body).to eq("New Description")
  end

  it 'display error with no title' do
    update_todo_list todo_list:todo_list, title: ""
    title = todo_list.title
    todo_list.reload
    expect(todo_list.title).to eq(title)
    expect(page).to have_content("error")
  end

  it 'display error with to short title' do
    update_todo_list todo_list:todo_list, title: "hi"
    expect(page).to have_content("error")
  end

  it 'display error with no body' do
    update_todo_list todo_list:todo_list, title: "Some new title", body: ""
    expect(page).to have_content("error")
  end

  it 'display error with to short body' do
    update_todo_list todo_list:todo_list, title: "New title1", body: "Helo"
    expect(page).to have_content("error")
  end
end
