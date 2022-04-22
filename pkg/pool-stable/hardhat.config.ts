import '@nomiclabs/hardhat-ethers';
import '@nomiclabs/hardhat-waffle';

import { hardhatBaseConfig } from '@balancer-labs/v2-common';
import { name } from './package.json';

import { task } from 'hardhat/config';
import { TASK_COMPILE } from 'hardhat/builtin-tasks/task-names';
import overrideQueryFunctions from '@balancer-labs/v2-helpers/plugins/overrideQueryFunctions';

task(TASK_COMPILE).setAction(overrideQueryFunctions);

require('./tasks/deployStablePoolFactory');

export default {
  networks: {
    hardhat: {
      allowUnlimitedContractSize: true,
    },
    mainnetfork: {
      url: 'http://127.0.0.1:8545/',
      gasPrice: process.env.GAS_PRICE ? parseInt(process.env.GAS_PRICE) * 10 ** 9 : 120 * 10 ** 9,
      // accounts: getAccounts('mainnet'),
      gasMultiplier: 1.2,
      timeout: 2000000,
      blockGasLimit: 20000000,
      allowUnlimitedContractSize: true,
    },
  },
  solidity: {
    compilers: hardhatBaseConfig.compilers,
    overrides: { ...hardhatBaseConfig.overrides(name) },
  },
};
