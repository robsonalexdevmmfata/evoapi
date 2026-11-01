import { join } from 'path';

export const ROOT_DIR = process.cwd();
export const DATA_DIR = process.env.DATA_DIR || ROOT_DIR;
export const INSTANCE_DIR = join(DATA_DIR, 'instances');
export const SRC_DIR = join(ROOT_DIR, 'src');
export const AUTH_DIR = join(DATA_DIR, 'store', 'auth');
export const STORE_DIR = join(DATA_DIR, 'store');
