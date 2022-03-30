defmodule Cumbabank.Bank.ChangesetHelper do
  import Ecto.Changeset
  import Pbkdf2, only: [add_hash: 1]

  def validate_email(changeset) do
    changeset
    |> validate_length(:email, min: 5, max: 255)
    |> validate_format(:email, ~r/@/)
  end

  def validate_password(changeset) do
    changeset
    |> validate_length(:password, min: 8)
  end

  def put_pass_hash(
        %Ecto.Changeset{valid?: true, changes: %{password: password}} =
          changeset
      ),
      do: change(changeset, add_hash(password))

  def put_pass_hash(changeset), do: changeset

  def uppercase_field(changeset, field) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: changes} ->
        if Map.has_key?(changes, field) and Map.get(changes, field) do
          changes =
            Map.replace!(
              changes,
              field,
              String.upcase(Map.get(changes, field))
            )

          Map.merge(changeset, %{changes: changes})
        else
          changeset
        end

      _ ->
        changeset
    end
  end

  def downcase_field(changeset, field) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: changes} ->
        if Map.has_key?(changes, field) and Map.get(changes, field) do
          changes =
            Map.replace!(
              changes,
              field,
              String.downcase(Map.get(changes, field))
            )

          Map.merge(changeset, %{changes: changes})
        else
          changeset
        end

      _ ->
        changeset
    end
  end

  def upload_file(
        changeset \\ nil,
        params \\ %{},
        attrs \\ %{},
        bucket \\ :billets_bucket,
        field \\ :file
      )

  def upload_file(changeset, _params, _attrs, _bucket, _field),
    do: changeset

  def unaccent_email(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{email: nil}} ->
        changeset

      %Ecto.Changeset{valid?: true, changes: %{email: email}} ->
        email =
          email
          |> String.normalize(:nfd)
          |> String.replace(~r/[^A-z0-9@._\-\s]/u, "")
          |> String.trim()

        Ecto.Changeset.change(changeset, %{email: email})

      _ ->
        changeset
    end
  end
end
