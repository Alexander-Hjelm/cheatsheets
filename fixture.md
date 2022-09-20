# Fixture, NUnit
<!--ts-->
<!--te-->

## Freeze eller ej?

Freeze används för att mocka ett **interface**. Om du försöker frysa ett vanligt objekt och sedan köra ReturnsForAnyArgs(), så kommer programmet försöka anropa klassmetoden med de argument du passar till ReturnsForAnyArgs().

Därför måste man refaktorera sitt SystemUnderTest så att det accepterar Interfaces som argument. Då kan man mocka dessa interfaces.

**Exempel**:

```csharp
[Test]
public async Task when_x_do_y()
{
    // Arrange
    var myMockedInterface = _fixture.Freeze<IMyMockedInterface>();
    myMockedInterface.myMockedMethod(Arg.Any<Type1>(), Arg.Any<Type2>()).ReturnsForAnyArgs("MyReturnVal");

    var jobLogger = _fixture.Create<IJobLogger>();
    var myOtherMockedInterface = _fixture.Create<IMyOtherMockedInterface>();

    // SystemUnderTest takes Interfaces as arguments
    var sut = new SystemUnderTest(
        logger: jobLogger,
        myMockedInterface: myMockedInterface,
        myOtherMockedInterface: myOtherMockedInterface
    );

    // Act
    var result = await sut.DoSmth();

    // Assert
    Assert.Multiple(() =>
    {
        Assert.That(result.val1, Is.Not.Null);
        Assert.That(result.val2, Is.Not.Empty);

    });
}
```
