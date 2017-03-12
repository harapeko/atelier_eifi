defmodule SampleApp.User do
  use SampleApp.Web, :model
  
  # 1.0 -> 1.1 でコールバックはdeprecatedされたぽい
  # Ecto.ModelもEcto.Schemaになっているぽい
  # じゃあ代わりにどうすればいいのか調べたけど、
  # 正直よくわからない。(Ecto.Multiを使うのかもしれない)
  # 本筋からブレるし、陳腐化した書籍に頼るより必要になったら0からやればいい
  # ということでpassword_digestへの格納はみなかったことにする

  # use Ecto.Model.Callbacks
  # before_insert :set_password_digest

  schema "users" do
    field :name, :string
    field :email, :string
    field :password_digest, :string
    field :password, :string, virtual: true

    timestamps()
  end

  # 多分いらないコード
  # @required_fields ~w(name email password)
  # @optional_fields ~w()

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email])
    |> validate_presence(:name)
    |> validate_presence(:email)
    |> validate_required([:name, :email])
    |> validate_format(:email, ~r/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i)
    |> unique_constraint(:name)
    |> unique_constraint(:email)
    |> validate_length(:name, min: 1)
    |> validate_length(:name, max: 50)
  end

  def set_password_digest(changeset) do
    password = Ecto.Changeset.get_field(changeset, :password)
    change(changeset,
      %{password_digest: SampleApp.Encryption.encrypt(password)})
  end
end