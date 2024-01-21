defmodule VendingMachine1Web.ErrorJSONTest do
  use VendingMachine1Web.ConnCase, async: true

  test "renders 404" do
    assert VendingMachine1Web.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert VendingMachine1Web.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
