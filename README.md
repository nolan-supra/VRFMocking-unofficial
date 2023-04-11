# VRFMocking---unofficial

for setup:

1. deploy ISupraRouterMock.sol
2. pass address of deployed contract from step 1 as the Supra VRF address to your contract implementing our VRF

for testing:

1. generate a request like you normally would through your contract implementing VRF
2. fulfill the request for that nonce by calling the fulfillRequest(nonce) function through the ISupraRouterMock.sol that we deployed in setup step 1


note:

there isn't a gas limit set rn on the .call when hitting the callback function - will have to add that
