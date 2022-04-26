@testset "Deme" begin
    # tests that validators are catching bad Deme inputs
    # test bad deme names
    @test_throws ErrorException Demes.validateDemeNameDescription(Dict(), Dict())
    @test_throws ErrorException Demes.validateDemeNameDescription(
        Dict("name" => "A"),
        Dict("A" => [Inf, 0]),
    )
    @test_throws MethodError Demes.Deme().name = 1
    @test_throws MethodError Demes.Deme().name = Inf
    @test_throws MethodError Demes.Deme().name = ["Hi"]
    @test_throws MethodError Demes.Deme().name = Dict("name" => "X")
    # test bad start time
    @test_throws ErrorException Demes.validateDemeStartTime(
        Dict("start_time" => -1),
        Dict(),
    )
    @test_throws ErrorException Demes.validateDemeStartTime(Dict("start_time" => 0), Dict())
    @test_throws ErrorException Demes.validateDemeStartTime(
        Dict("ancestors" => ["A"], "start_time" => 10),
        Dict("A" => [Inf, 20]),
    )
    @test_throws ErrorException Demes.validateDemeStartTime(
        Dict("ancestors" => ["A"], "start_time" => 10),
        Dict("A" => [5, 0]),
    )
    @test_throws ErrorException Demes.validateDemeStartTime(
        Dict("ancestors" => ["A"], "start_time" => 10),
        Dict("A" => [Inf, 10 + 1e-12]),
    )
    @test_throws ErrorException Demes.validateDemeStartTime(
        Dict("ancestors" => ["A"], "start_time" => 10),
        Dict("A" => [10, 0]),
    )
    @test_throws ErrorException Demes.validateDemeStartTime(
        Dict("ancestors" => ["A", "B"], "start_time" => 10),
        Dict("A" => [Inf, 0], "B" => [Inf, 20]),
    )
    @test_throws ErrorException Demes.validateDemeStartTime(
        Dict("ancestors" => ["A", "B"], "start_time" => 10),
        Dict("A" => [Inf, 0], "B" => [5, 0]),
    )
    @test_throws MethodError Demes.Deme().start_time = "1"
    @test_throws MethodError Demes.Deme().start_time = [1]
    # test bad ancestor proportions
    @test_throws ErrorException Demes.validateDemeAncestorsProportions(["A", "B"], [])
    @test_throws ErrorException Demes.validateDemeAncestorsProportions(["A", "B"], [1])
    @test_throws ErrorException Demes.validateDemeAncestorsProportions(
        ["A", "B"],
        [0.2, 0.4],
    )
end
