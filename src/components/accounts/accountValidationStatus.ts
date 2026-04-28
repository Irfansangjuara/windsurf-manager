import type { TFunction } from 'i18next';

const RATE_LIMIT_HINTS = [
    'resource_exhausted',
    'too many requests',
    '429',
    'rate limit',
    'rate-limited',
    'risk control',
    'risk-controlled',
    '风控',
    '冻结',
    'frozen',
];

const OAUTH_HINTS = [
    'unauthorized_client',
    'invalid_client',
    'invalid_grant',
    'oauth client',
    'not authorized',
];

const DEVICE_LIMIT_HINTS = [
    'permission_denied',
    'too many free user accounts for this device',
    'existing account or upgrade to a paid plan',
    'device limit',
];

function includesAny(text: string, hints: string[]): boolean {
    return hints.some((hint) => text.includes(hint));
}

export function getValidationBlockedStatusLabel(
    reason: string | undefined,
    t: TFunction,
): string {
    const normalizedReason = (reason || '').toLowerCase();

    if (includesAny(normalizedReason, RATE_LIMIT_HINTS)) {
        return t('accounts.status.risk_controlled', { defaultValue: 'Risk / Rate Limited' });
    }

    if (includesAny(normalizedReason, DEVICE_LIMIT_HINTS)) {
        return t('accounts.status.device_limit_reached', { defaultValue: 'Device Limit Reached' });
    }

    if (includesAny(normalizedReason, OAUTH_HINTS)) {
        return t('accounts.status.oauth_reauth_required', { defaultValue: 'OAuth Re-auth Required' });
    }

    return t('accounts.status.validation_required', { defaultValue: 'Verification Required' });
}
