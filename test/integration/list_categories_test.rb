require 'test_helper'

class ListCategoriestest < ActionDispatch::IntegrationTest

  def setup
    @category = Category.create(name: 'sports')
    @category2 = Category.create(name: 'programming')
    @user = User.create(username: "john", email: "john@example.com", password: "password", admin: true)
  end

  test "should show categories listing" do
    get categories_path
    assert_template 'categories/index'
    assert_select 'a[href=?]', category_path(@category), text: @category.name
    assert_select 'a[href=?]', category_path(@category2), text: @category2.name
  end

  test "invalid category submission results in failure" do
    sign_in_as(@user, "password")
    get new_category_path
    assert_template 'categories/new'
    assert_no_difference 'Category.count' do
      post categories_path, params: {category: {name: ' '}}
    end
    assert_template 'categories/new'
    assert_select "h2.alert-title"
    assert_select 'div.alert-body'
  end
end