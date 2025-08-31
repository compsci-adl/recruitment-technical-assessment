import express, { Request, Response } from 'express';

// ==== DO NOT CHANGE ==========================================================
const app = express();
app.use(express.json());

// ==== Type Definitions, feel free to add or modify ===========================
interface RequiredResource {
  name: string;
  quantity: number;
}

interface ProjectEntry {
  type: 'project';
  name: string;
  requiredResources: RequiredResource[];
}

interface ResourceEntry {
  type: 'resource';
  name: string;
  buildTime: number;
}

type Entry = ProjectEntry | ResourceEntry;

const projectRegistry: Record<string, Entry> = {};

// ==== Task 1 ================================================================
export function slugToTitle(slug: string): string {
  // TODO: Convert hyphenated lowercase string into title-cased string
  return '';
}

// ==== Task 2 ================================================================
app.post('/projectEntry', (req: Request, res: Response) => {
  const data: Entry = req.body;
  // TODO: Validate input and store in `projectRegistry`
  res.sendStatus(200);
});

// ==== Task 3 ================================================================
app.get('/summary', (req: Request, res: Response) => {
  const name = req.query.name as string;
  // TODO: Lookup entry, compute buildTime and ingredients recursively
  res.sendStatus(200);
});

// ==== DO NOT CHANGE ==========================================================
app.listen(8080, () => {
  console.log('Server running on http://127.0.0.1:8080');
});
