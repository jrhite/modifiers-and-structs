const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Greeter", function () {
  let greeter;
  let owner, nonOwner;

  before(async function () {
    [owner, nonOwner] = await ethers.getSigners();

    const Greeter = await ethers.getContractFactory('Greeter', owner);
    greeter = await Greeter.deploy('Hello, world!', 2);
    await greeter.deployed();
  });

  it('Should change the greeting if setGreeting() is called by owner', async function () {
    expect(await greeter.greet()).to.equal('Hello, world!');

    const setGreetingTx = await greeter.setGreeting('Hola, mundo!');

    // wait until the transaction is mined
    await setGreetingTx.wait();

    expect(await greeter.greet()).to.equal('Hola, mundo!');
  });

  it("Should revert if setGreeting() is called by non-owner", async function () {
    const greeterContractWithNonOwnerSigner = await greeter.connect(nonOwner);

    const setGreetingTx =
      greeterContractWithNonOwnerSigner.setGreeting('Hola, mundo!');

    await expect(setGreetingTx).to.be.revertedWith(
      'Sorry, only the owner can call this function!');
  });

  it('Should change the favorite number if setFavoriteNumber() is called with an even number', async function () {
    const setGreetingTx = await greeter.setFavoriteNumber(8);

    // wait until the transaction is mined
    await setGreetingTx.wait();

    expect(await greeter.favoriteNumber()).to.equal(8);
  });

  it('Should revert if setFavoriteNumber() is called by non-owner', async function () {
    const greeterContractWithNonOwnerSigner = await greeter.connect(nonOwner);

    const setFavoriteNumberTx =
      greeterContractWithNonOwnerSigner.setFavoriteNumber(8);

    await expect(setFavoriteNumberTx).to.be.revertedWith(
      'Sorry, only the owner can call this function!'
    );
  });

  it('Should revert if setFavoriteNumber() is called with an odd number', async function () {
    const setFavoriteNumberTx = greeter.setFavoriteNumber(9);

    await expect(setFavoriteNumberTx).to.be.revertedWith(
      'Sorry, only even numbers allowed!'
    );
  });
});