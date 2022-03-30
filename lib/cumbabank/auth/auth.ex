defmodule Cumbabank.Auth do
  use Guardian, otp_app: :cumbabank

  def subject_for_token(resource, _claims) do
    resource = %{
      __struct__: resource.__struct__,
      id: resource.id,
      email: resource.email,
      cpf: resource.cpf,
      name: resource.name,
    }

    {:ok, serialize_subject(resource)}
  end

  def build_claims(claims, resource, _opts) do
    claims =
      Map.put(claims, "exp", 4_102_444_799)

    {:ok, claims}
  end

  def resource_from_claims(claims) do
    user = deserialize_subject(claims["sub"])

    case user do
      %{__struct__: Cumbabank.Bank.User} -> {:ok, user}
      _ -> {:error, nil}
    end
  end

  defp serialize_subject(subject) do
    subject = :erlang.term_to_binary(subject)
    Base.encode64(subject)
  end

  defp deserialize_subject(subject) do
    {:ok, subject} = Base.decode64(subject)
    :erlang.binary_to_term(subject)
  end
end
