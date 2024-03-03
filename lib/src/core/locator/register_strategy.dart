/// Register strategy for the locator.
///
/// [doNotOverride] - Do not override the existing instance.
/// Will throw an exception if the instance is already registered.
///
/// [override] - Override the existing instance.
/// Will override the existing instance if it is already registered.
/// If the instance is not registered, it will register the instance.
enum RegisterStrategy {
  doNotOverride,
  override,
}
