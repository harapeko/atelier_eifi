defmodule DemoApp.Micropost do
  use DemoApp.Web, :model

  schema "microposts" do
    field :content, :string
    belongs_to :user, DemoApp.User, foreign_key: :user_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:content, :user_id])
    |> validate_required([:content, :user_id])
    |> validate_length(:content, max: 140) # 最大140文字制限
  end
end
