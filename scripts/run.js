const main = async () => {
    const gmContractFactory = await hre.ethers.getContractFactory('GmPortal');
    const gmContract = await gmContractFactory.deploy(
      {
        value: hre.ethers.utils.parseEther('0.1'),
      }
    );
    await gmContract.deployed();
  
    console.log('Contract deployed to:', gmContract.address);
  
    let gmCount;
    gmCount = await gmContract.getTotalGms();

    /*
    * Get Contract balance
    */
    let contractBalance = await hre.ethers.provider.getBalance(
      gmContract.address
    );
    console.log(
      'Contract balance:',
      hre.ethers.utils.formatEther(contractBalance)
    );
  
    let gmTxn = await gmContract.gm('Foo');
    await gmTxn.wait(); // Wait for the transaction to be mined

    const [_, randomPerson] = await hre.ethers.getSigners();
    gmTxn = await gmContract.connect(randomPerson).gm('Bar');
    await gmTxn.wait(); // Wait for the transaction to be mined

    let allGms = await gmContract.getAllGms();
    console.log(allGms);

    contractBalance = await hre.ethers.provider.getBalance(gmContract.address);
    console.log(
      'Contract balance:',
      hre.ethers.utils.formatEther(contractBalance)
    );
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