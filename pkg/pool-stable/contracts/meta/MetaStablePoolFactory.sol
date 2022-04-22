// SPDX-License-Identifier: GPL-3.0-or-later
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

pragma solidity ^0.7.0;
pragma experimental ABIEncoderV2;

import "@powerpool/balancer-v2-vault/contracts/interfaces/IVault.sol";

import "@powerpool/balancer-v2-pool-utils/contracts/factories/BasePoolSplitCodeFactory.sol";
import "@powerpool/balancer-v2-pool-utils/contracts/factories/FactoryWidePauseWindow.sol";

import "./MetaStablePool.sol";

contract MetaStablePoolFactory is BasePoolSplitCodeFactory, FactoryWidePauseWindow {
    constructor(IVault vault) BasePoolSplitCodeFactory(vault, type(MetaStablePool).creationCode) {
        // solhint-disable-previous-line no-empty-blocks
    }

    /**
     * @dev Deploys a new `MetaStablePool`.
     */
    function create(
        string memory name,
        string memory symbol,
        IERC20[] memory tokens,
        address[] memory assetManagers,
        uint256 amplificationParameter,
        IRateProvider[] memory rateProviders,
        uint256[] memory priceRateCacheDuration,
        uint256 swapFeePercentage,
        bool oracleEnabled,
        address owner
    ) external returns (address) {
        (uint256 pauseWindowDuration, uint256 bufferPeriodDuration) = getPauseConfiguration();

        return
            _create(
                abi.encode(
                    MetaStablePool.NewPoolParams({
                        vault: getVault(),
                        name: name,
                        symbol: symbol,
                        tokens: tokens,
                        assetManagers: assetManagers,
                        rateProviders: rateProviders,
                        priceRateCacheDuration: priceRateCacheDuration,
                        amplificationParameter: amplificationParameter,
                        swapFeePercentage: swapFeePercentage,
                        pauseWindowDuration: pauseWindowDuration,
                        bufferPeriodDuration: bufferPeriodDuration,
                        oracleEnabled: oracleEnabled,
                        owner: owner
                    })
                )
            );
    }
}
