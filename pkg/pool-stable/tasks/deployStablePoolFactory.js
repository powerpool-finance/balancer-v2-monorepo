require('@nomiclabs/hardhat-ethers');

task('deploy-stable-pool-factory', 'Deploy LUSD Asset Manager').setAction(async (__, {ethers, network}) => {
  const StablePoolFactory = await ethers.getContractFactory('StablePoolFactory');
  const [deployer] = await ethers.getSigners().then(signers => signers.map(s => s.address));

  console.log('deployer', deployer);

  const authorizerAddress = '0xa331d84ec860bf466b4cdccfb4ac09a1b43f3ae6';
  const vaultAddress = '0xba12222222228d8ba445958a75a0704d566bf2c8';
  const daoMultisigAddress = '0x10a19e7ee7d7f8a52822f6817de8ea18204f2e4f';

  const stablePoolFactory = await StablePoolFactory.deploy(vaultAddress);
  console.log('stablePoolFactory.address', stablePoolFactory.address);
});
