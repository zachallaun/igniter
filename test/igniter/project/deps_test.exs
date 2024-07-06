defmodule Igniter.Project.DepsTest do
  use ExUnit.Case

  describe "add_dep/3" do
    test "adds the provided dependency" do
      refute Igniter.Project.Deps.get_dependency_declaration(Igniter.new(), :foobar)

      igniter = Igniter.Project.Deps.add_dep(Igniter.new(), {:foobar, "~> 2.0"})

      assert Igniter.Project.Deps.get_dependency_declaration(igniter, :foobar) ==
               "{:foobar, \"~> 2.0\"}"
    end

    test "adds the provided dependency with options" do
      refute Igniter.Project.Deps.get_dependency_declaration(Igniter.new(), :foobar)

      igniter = Igniter.Project.Deps.add_dep(Igniter.new(), {:foobar, "~> 2.0", only: :test})

      assert Igniter.Project.Deps.get_dependency_declaration(igniter, :foobar) ==
               "{:foobar, \"~> 2.0\", only: :test}"
    end
  end

  # describe "configure/6" do
  #   test "it creates the config file if it does not exist" do
  #     %{rewrite: rewrite} =
  #       Igniter.Project.Config.configure(Igniter.new(), "fake.exs", :fake, [:foo, :bar], "baz")

  #     config_file = Rewrite.source!(rewrite, "config/fake.exs")

  #     assert Source.from?(config_file, :string)

  #     assert Source.get(config_file, :content) == """
  #            import Config
  #            config :fake, foo: [bar: "baz"]
  #            """
  #   end

  #   test "it merges with 2 arg version of existing config" do
  #     %{rewrite: rewrite} =
  #       Igniter.new()
  #       |> Igniter.create_new_elixir_file("config/fake.exs", """
  #         import Config

  #         config :fake, buz: [:blat]
  #       """)
  #       |> Igniter.Project.Config.configure("fake.exs", :fake, [:foo, :bar], "baz")

  #     config_file = Rewrite.source!(rewrite, "config/fake.exs")

  #     assert Source.get(config_file, :content) == """
  #            import Config

  #            config :fake, buz: [:blat], foo: [bar: "baz"]
  #            """
  #   end

  #   @tag :regression
  #   test "it merges the spark formatter plugins" do
  #     %{rewrite: rewrite} =
  #       Igniter.new()
  #       |> Igniter.Project.Config.configure(
  #         "fake.exs",
  #         :spark,
  #         [:formatter, :"Ash.Resource"],
  #         [],
  #         updater: fn x ->
  #           x
  #         end
  #       )
  #       |> Igniter.Project.Config.configure("fake.exs", :spark, [:formatter, :"Ash.Domain"], [],
  #         updater: fn x ->
  #           x
  #         end
  #       )

  #     config_file = Rewrite.source!(rewrite, "config/fake.exs")

  #     assert Source.get(config_file, :content) == """
  #            import Config
  #            config :spark, formatter: ["Ash.Resource": [], "Ash.Domain": []]
  #            """
  #   end

  #   test "it merges with 2 arg version of existing config with a single path item" do
  #     %{rewrite: rewrite} =
  #       Igniter.new()
  #       |> Igniter.create_new_elixir_file("config/fake.exs", """
  #         import Config

  #         config :fake, buz: [:blat]
  #       """)
  #       |> Igniter.Project.Config.configure("fake.exs", :fake, [:foo], "baz")

  #     config_file = Rewrite.source!(rewrite, "config/fake.exs")

  #     assert Source.get(config_file, :content) == """
  #            import Config

  #            config :fake, buz: [:blat], foo: "baz"
  #            """
  #   end

  #   test "it choosees the thre 3 arg version when first item in path is not pretty" do
  #     %{rewrite: rewrite} =
  #       Igniter.new()
  #       |> Igniter.create_new_elixir_file("config/fake.exs", """
  #         import Config
  #       """)
  #       |> Igniter.Project.Config.configure("fake.exs", :fake, [Foo.Bar, :bar], "baz")

  #     config_file = Rewrite.source!(rewrite, "config/fake.exs")

  #     assert Source.get(config_file, :content) == """
  #            import Config
  #            config :fake, Foo.Bar, bar: "baz"
  #            """
  #   end

  #   test "it choosees the thre 3 arg version when first item in path is not pretty, and merges that way" do
  #     %{rewrite: rewrite} =
  #       Igniter.new()
  #       |> Igniter.create_new_elixir_file("config/fake.exs", """
  #         import Config
  #       """)
  #       |> Igniter.Project.Config.configure("fake.exs", :fake, [Foo.Bar, :bar], "baz")
  #       |> Igniter.Project.Config.configure("fake.exs", :fake, [Foo.Bar, :buz], "biz")

  #     config_file = Rewrite.source!(rewrite, "config/fake.exs")

  #     assert Source.get(config_file, :content) == """
  #            import Config
  #            config :fake, Foo.Bar, bar: "baz", buz: "biz"
  #            """
  #   end

  #   test "it merges with 3 arg version of existing config" do
  #     %{rewrite: rewrite} =
  #       Igniter.new()
  #       |> Igniter.create_new_elixir_file("config/fake.exs", """
  #         import Config

  #         config :fake, :buz, [:blat]
  #       """)
  #       |> Igniter.Project.Config.configure("fake.exs", :fake, [:foo, :bar], "baz")

  #     config_file = Rewrite.source!(rewrite, "config/fake.exs")

  #     assert Source.get(config_file, :content) == """
  #            import Config

  #            config :fake, foo: [bar: "baz"]
  #            config :fake, :buz, [:blat]
  #            """
  #   end

  #   test "it merges with 3 arg version of existing config with a single path item" do
  #     %{rewrite: rewrite} =
  #       Igniter.new()
  #       |> Igniter.create_new_elixir_file("config/fake.exs", """
  #         import Config

  #         config :fake, :buz, [:blat]
  #       """)
  #       |> Igniter.Project.Config.configure("fake.exs", :fake, [:foo], "baz")

  #     config_file = Rewrite.source!(rewrite, "config/fake.exs")

  #     assert Source.get(config_file, :content) == """
  #            import Config

  #            config :fake, foo: "baz"
  #            config :fake, :buz, [:blat]
  #            """
  #   end

  #   test "present values can be updated" do
  #     %{rewrite: rewrite} =
  #       Igniter.new()
  #       |> Igniter.create_new_elixir_file("config/fake.exs", """
  #         import Config

  #         config :fake, :buz, [:blat]
  #       """)
  #       |> Igniter.Project.Config.configure("fake.exs", :fake, [:buz], "baz",
  #         updater: fn list ->
  #           Igniter.Code.List.prepend_new_to_list(list, "baz")
  #         end
  #       )

  #     config_file = Rewrite.source!(rewrite, "config/fake.exs")

  #     assert Source.get(config_file, :content) == """
  #            import Config

  #            config :fake, :buz, ["baz", :blat]
  #            """
  #   end

  #   test "we merge configs even in large config files" do
  #     %{rewrite: rewrite} =
  #       Igniter.new()
  #       |> Igniter.create_new_elixir_file("config/fake.exs", """
  #       # this is too

  #       import Config

  #       # this is a comment

  #       config :fake, :buz, [:blat]

  #       # trailing comment
  #       """)
  #       |> Igniter.Project.Config.configure("fake.exs", :fake, [:buz], "baz",
  #         updater: fn list ->
  #           Igniter.Code.List.prepend_new_to_list(list, "baz")
  #         end
  #       )
  #       |> Igniter.prepare_for_write()

  #     config_file = Rewrite.source!(rewrite, "config/fake.exs")

  #     assert Source.get(config_file, :content) == """
  #            # this is too

  #            import Config

  #            # this is a comment

  #            config :fake, :buz, ["baz", :blat]

  #            # trailing comment
  #            """
  #   end

  #   test "integers can be used as values" do
  #     %{rewrite: rewrite} =
  #       Igniter.new()
  #       |> Igniter.create_new_elixir_file("config/fake.exs", """
  #         import Config

  #         config :fake, :buz, [:blat]
  #       """)
  #       |> Igniter.Project.Config.configure("fake.exs", :fake, [:buz], 12)

  #     config_file = Rewrite.source!(rewrite, "config/fake.exs")

  #     assert Source.get(config_file, :content) == """
  #            import Config

  #            config :fake, :buz, 12
  #            """
  #   end

  #   test "present values can be updated by updating map keys" do
  #     %{rewrite: rewrite} =
  #       Igniter.new()
  #       |> Igniter.create_new_elixir_file("config/fake.exs", """
  #         import Config

  #         config :fake, foo: %{"a" => ["a", "b"]}
  #       """)
  #       |> Igniter.Project.Config.configure("fake.exs", :fake, [:foo], %{"b" => ["c", "d"]},
  #         updater: fn zipper ->
  #           Igniter.Code.Map.set_map_key(zipper, "b", ["c", "d"], fn zipper ->
  #             with {:ok, zipper} <- Igniter.Code.List.prepend_new_to_list(zipper, "c") do
  #               Igniter.Code.List.prepend_new_to_list(zipper, "d")
  #             end
  #           end)
  #         end
  #       )

  #     config_file = Rewrite.source!(rewrite, "config/fake.exs")

  #     assert Source.get(config_file, :content) == """
  #            import Config

  #            config :fake, foo: %{"a" => ["a", "b"], "b" => ["c", "d"]}
  #            """
  #   end

  #   test "it presents users with instructions on how to update a malformed config" do
  #     %{warnings: [warning]} =
  #       Igniter.new()
  #       |> Igniter.create_new_elixir_file("config/fake.exs", """
  #         config :fake, foo: %{"a" => ["a", "b"]}
  #       """)
  #       |> Igniter.Project.Config.configure("fake.exs", :fake, [:foo], %{"b" => ["c", "d"]},
  #         failure_message: "A failure message!"
  #       )

  #     assert warning == """
  #            Please set the following config in config/fake.exs:

  #                config :fake, foo: %{"b" => ["c", "d"]}

  #            A failure message!
  #            """
  #   end
  # end
end
