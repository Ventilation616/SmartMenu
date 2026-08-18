abstract class UseCase<Output, Input> {
  Future<Output> call(Input input);
}

class NoParams {
  const NoParams();
}
