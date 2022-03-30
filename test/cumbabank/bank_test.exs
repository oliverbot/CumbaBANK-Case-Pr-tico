defmodule Cumbabank.BankTest do
  use Cumbabank.DataCase

  alias Cumbabank.Bank

  describe "transactions" do
    alias Cumbabank.Bank.Transaction

    import Cumbabank.BankFixtures

    @invalid_attrs %{amount: nil, returned: nil}

    test "list_transactions/0 returns all transactions" do
      transaction = transaction_fixture()
      assert Bank.list_transactions() == [transaction]
    end

    test "get_transaction!/1 returns the transaction with given id" do
      transaction = transaction_fixture()
      assert Bank.get_transaction!(transaction.id) == transaction
    end

    test "create_transaction/1 with valid data creates a transaction" do
      valid_attrs = %{amount: "120.5", returned: true}

      assert {:ok, %Transaction{} = transaction} = Bank.create_transaction(valid_attrs)
      assert transaction.amount == Decimal.new("120.5")
      assert transaction.returned == true
    end

    test "create_transaction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Bank.create_transaction(@invalid_attrs)
    end

    test "update_transaction/2 with valid data updates the transaction" do
      transaction = transaction_fixture()
      update_attrs = %{amount: "456.7", returned: false}

      assert {:ok, %Transaction{} = transaction} = Bank.update_transaction(transaction, update_attrs)
      assert transaction.amount == Decimal.new("456.7")
      assert transaction.returned == false
    end

    test "update_transaction/2 with invalid data returns error changeset" do
      transaction = transaction_fixture()
      assert {:error, %Ecto.Changeset{}} = Bank.update_transaction(transaction, @invalid_attrs)
      assert transaction == Bank.get_transaction!(transaction.id)
    end

    test "delete_transaction/1 deletes the transaction" do
      transaction = transaction_fixture()
      assert {:ok, %Transaction{}} = Bank.delete_transaction(transaction)
      assert_raise Ecto.NoResultsError, fn -> Bank.get_transaction!(transaction.id) end
    end

    test "change_transaction/1 returns a transaction changeset" do
      transaction = transaction_fixture()
      assert %Ecto.Changeset{} = Bank.change_transaction(transaction)
    end
  end

  describe "accounts" do
    alias Cumbabank.Bank.Account

    import Cumbabank.BankFixtures

    @invalid_attrs %{current_balance: nil, initial_balance: nil}

    test "list_accounts/0 returns all accounts" do
      account = account_fixture()
      assert Bank.list_accounts() == [account]
    end

    test "get_account!/1 returns the account with given id" do
      account = account_fixture()
      assert Bank.get_account!(account.id) == account
    end

    test "create_account/1 with valid data creates a account" do
      valid_attrs = %{current_balance: "120.5", initial_balance: "120.5"}

      assert {:ok, %Account{} = account} = Bank.create_account(valid_attrs)
      assert account.current_balance == Decimal.new("120.5")
      assert account.initial_balance == Decimal.new("120.5")
    end

    test "create_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Bank.create_account(@invalid_attrs)
    end

    test "update_account/2 with valid data updates the account" do
      account = account_fixture()
      update_attrs = %{current_balance: "456.7", initial_balance: "456.7"}

      assert {:ok, %Account{} = account} = Bank.update_account(account, update_attrs)
      assert account.current_balance == Decimal.new("456.7")
      assert account.initial_balance == Decimal.new("456.7")
    end

    test "update_account/2 with invalid data returns error changeset" do
      account = account_fixture()
      assert {:error, %Ecto.Changeset{}} = Bank.update_account(account, @invalid_attrs)
      assert account == Bank.get_account!(account.id)
    end

    test "delete_account/1 deletes the account" do
      account = account_fixture()
      assert {:ok, %Account{}} = Bank.delete_account(account)
      assert_raise Ecto.NoResultsError, fn -> Bank.get_account!(account.id) end
    end

    test "change_account/1 returns a account changeset" do
      account = account_fixture()
      assert %Ecto.Changeset{} = Bank.change_account(account)
    end
  end

  describe "users" do
    alias Cumbabank.Bank.User

    import Cumbabank.BankFixtures

    @invalid_attrs %{cpf: nil, email: nil, name: nil, password: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Bank.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Bank.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{cpf: "some cpf", email: "some email", name: "some name", password: "some password"}

      assert {:ok, %User{} = user} = Bank.create_user(valid_attrs)
      assert user.cpf == "some cpf"
      assert user.email == "some email"
      assert user.name == "some name"
      assert user.password == "some password"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Bank.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{cpf: "some updated cpf", email: "some updated email", name: "some updated name", password: "some updated password"}

      assert {:ok, %User{} = user} = Bank.update_user(user, update_attrs)
      assert user.cpf == "some updated cpf"
      assert user.email == "some updated email"
      assert user.name == "some updated name"
      assert user.password == "some updated password"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Bank.update_user(user, @invalid_attrs)
      assert user == Bank.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Bank.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Bank.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Bank.change_user(user)
    end
  end
end
