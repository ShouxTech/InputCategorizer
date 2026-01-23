import { Atom } from '@rbxts/charm';

export type InputCategory = 'KeyboardAndMouse' | 'Gamepad' | 'Touch' | 'Unknown';

declare namespace InputCategorizer {
	const inputCategoryAtom: Atom<InputCategory>;
}

export = InputCategorizer;