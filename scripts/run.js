const main = async () => {
    const gmContractFactory = await hre.ethers.getContractFactory('GmPortal');
    const gmContract = await gmContractFactory.deploy();
    await gmContract.deployed();
  
    console.log('Contract deployed to:', gmContract.address);
  
    let gmCount;
    gmCount = await gmContract.getTotalGms();
  
    let gmTxn = await gmContract.gm('Foo');
    await gmTxn.wait(); // Wait for the transaction to be mined

    const [_, randomPerson] = await hre.ethers.getSigners();
    gmTxn = await gmContract.connect(randomPerson).gm('Bar');
    await gmTxn.wait(); // Wait for the transaction to be mined

    let allGms = await gmContract.getAllGms();
    console.log(allGms);
  };
  
  const runMain = async () => {
    try {
      await main();
      process.exit(0);
    } catch (error) {
      console.log(error);
      process.exit(1);
    }
  };
  
  runMain();