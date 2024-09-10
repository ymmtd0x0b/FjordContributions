import { NodeHtmlMarkdown } from 'node-html-markdown'

const clipboardMarkdonw = FlowbiteInstances.getInstance('CopyClipboard', 'markdown');
const clipboardExternalID = FlowbiteInstances.getInstance('CopyClipboard', 'url');

const tooltipMarkdonw = FlowbiteInstances.getInstance('Tooltip', 'tooltip-markdown');
const tooltipExternalID = FlowbiteInstances.getInstance('Tooltip', 'tooltip-url');

const clipboards = [
	{
		clipboard: clipboardMarkdonw,
		tooltip: tooltipMarkdonw,
		defaultMessage: document.getElementById('default-tooltip-message-markdown'),
		successMessage: document.getElementById('success-tooltip-message-markdown'),
		defaultIcon: document.getElementById('default-icon-markdown'),
		successIcon: document.getElementById('success-icon-markdown')
	},
	{
		clipboard: clipboardExternalID,
		tooltip: tooltipExternalID,
		defaultMessage: document.getElementById('default-tooltip-message-url'),
		successMessage: document.getElementById('success-tooltip-message-url'),
		defaultIcon: document.getElementById('default-icon-url'),
		successIcon: document.getElementById('success-icon-url')
	}
]

export default function () {
	clipboards.forEach((item) => {
		item.clipboard._triggerEl.addEventListener('click', () => {
			if(item.clipboard._instanceId === 'markdown') {
				const markdonwText = NodeHtmlMarkdown.translate(
					document.getElementById('contributions-table').innerHTML,
					{ bulletMarker: '-' }
				)
				navigator.clipboard.writeText(markdonwText)
			} else {
				navigator.clipboard.writeText(document.location.href)
			}

			showSuccess(item.defaultMessage, item.successMessage);
			showSuccess(item.defaultIcon, item.successIcon);
			item.tooltip.show();

			// reset to default state
			setTimeout(() => {
				resetToDefault(item.defaultMessage, item.successMessage);
				resetToDefault(item.defaultIcon, item.successIcon);
				item.tooltip.hide();
			}, 2000);
		})
	})
}

const showSuccess = ($defaultEl, $successEl) => {
	$defaultEl.classList.add('hidden');
	$successEl.classList.remove('hidden');
}

const resetToDefault = ($defaultEl, $successEl) => {
	$defaultEl.classList.remove('hidden');
	$successEl.classList.add('hidden');
}
