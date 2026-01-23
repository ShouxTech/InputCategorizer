--!strict
local UserInputService = game:GetService('UserInputService');

local dependencies = script.Parent.Parent;
local Charm = require(dependencies:FindFirstChild('charm') or dependencies.Charm);

export type InputCategory = 'KeyboardAndMouse' | 'Gamepad' | 'Touch' | 'Unknown'

local lastInputTypeAtom = Charm.atom(UserInputService:GetLastInputType());

UserInputService.LastInputTypeChanged:Connect(lastInputTypeAtom)

local function categorizeInput(inputType: Enum.UserInputType): InputCategory
	if inputType.Name:find('Gamepad') then
		return 'Gamepad';
	elseif inputType == Enum.UserInputType.Keyboard or inputType.Name:find('Mouse') then
		return 'KeyboardAndMouse';
	elseif inputType == Enum.UserInputType.Touch then
		return 'Touch';
	else
		return 'Unknown';
	end;
end;

local InputCategorizer = {};

InputCategorizer.inputCategoryAtom = Charm.computed(function(): InputCategory
	local lastInputType = lastInputTypeAtom();

	local category = categorizeInput(lastInputType);
	if category ~= 'Unknown' then
		return category;
	end;

	if UserInputService.KeyboardEnabled and UserInputService.MouseEnabled then
		return 'KeyboardAndMouse'
	elseif UserInputService.TouchEnabled then
		return 'Touch';
	elseif UserInputService.GamepadEnabled then
		return 'Gamepad';
	else
		return 'Unknown';
	end;
end);

return InputCategorizer;