require 'rails_helper'

describe 'Viewing todo items' do
  let!(:todo_list){ TodoList.create(title: 'some list', body: 'body text of list') }

  def visit_todo_list(list)
    visit '/todo_lists'
    within "#todo_list_#{list.id}" do
      click_link "List Items"
    end
  end

  it "display the title of the todo list" do
    visit_todo_list(todo_list)
    within("h1") do
      expect(page).to have_content(todo_list.title)
    end
  end

  it "display no items a todo list is empty" do

    expect(page.all("ul.todo_items li").size).to eq(0)
  end

  it "display itemmcontent when a todo list has items" do
    todo_list.todo_items.create(content: "milk")
    todo_list.todo_items.create(content: "eggs")

    visit_todo_list(todo_list)

    expect(page.all("ul.todo_items li").size).to eq(2)

    within "ul.todo_items" do
      expect(page).to have_content("milk")
      expect(page).to have_content("eggs")
    end

  end
end