# React Interview Study Guide

A comprehensive reference covering all major React topics for interview preparation. Work through each chapter sequentially or jump to the areas where you need the most practice.

---

## Table of Contents

1. [JavaScript Fundamentals for React](#1-javascript-fundamentals-for-react)
2. [React Core Concepts](#2-react-core-concepts)
3. [React Hooks (Deep Dive)](#3-react-hooks-deep-dive)
4. [Rendering & Performance](#4-rendering--performance)
5. [State Management](#5-state-management)
6. [Routing](#6-routing)
7. [Forms & Validation](#7-forms--validation)
8. [Styling Approaches](#8-styling-approaches)
9. [Data Fetching & Side Effects](#9-data-fetching--side-effects)
10. [Testing](#10-testing)
11. [TypeScript with React](#11-typescript-with-react)
12. [Architecture & Patterns](#12-architecture--patterns)
13. [Next.js & SSR](#13-nextjs--ssr)
14. [Accessibility (a11y)](#14-accessibility-a11y)
15. [Common Interview Questions](#15-common-interview-questions)

---

## 1. JavaScript Fundamentals for React

React interviews almost always probe your JS foundations. A shaky understanding of closures or async patterns will surface quickly.

### 1.1 ES6+ Essentials

**Arrow functions & lexical `this`**

Arrow functions do not have their own `this` binding — they inherit it from the enclosing lexical scope. This is critical in React class components and in callbacks.

```js
// Regular function — `this` depends on call site
function Timer() {
  this.seconds = 0;
  setInterval(function () {
    this.seconds++; // ❌ `this` is undefined (strict) or global
  }, 1000);
}

// Arrow function — `this` is inherited
function Timer() {
  this.seconds = 0;
  setInterval(() => {
    this.seconds++; // ✅ `this` refers to the Timer instance
  }, 1000);
}
```

**Destructuring**

```js
// Object destructuring
const { name, age, city = 'Unknown' } = user;

// Array destructuring
const [first, , third] = [1, 2, 3];

// Nested destructuring
const { address: { street } } = user;

// In function parameters
function greet({ name, age }) { ... }
```

**Spread & rest operators**

```js
// Spread — expand iterable
const merged = { ...defaults, ...overrides };
const copy = [...arr];

// Rest — collect remaining arguments
function sum(...nums) {
  return nums.reduce((a, b) => a + b, 0);
}
```

**Optional chaining & nullish coalescing**

```js
const city = user?.address?.city;           // undefined if any step is null/undefined
const name = user.name ?? 'Anonymous';      // fallback only for null/undefined (not 0 or '')
const length = arr?.length ?? 0;
```

**Modules**

```js
// Named exports
export const PI = 3.14;
export function add(a, b) { return a + b; }

// Default export
export default function App() { ... }

// Imports
import App, { PI, add } from './module';
import * as utils from './utils';
```

---

### 1.2 Asynchronous JavaScript

**Promises**

```js
fetch('/api/users')
  .then(res => res.json())
  .then(data => console.log(data))
  .catch(err => console.error(err))
  .finally(() => setLoading(false));
```

**async / await**

```js
async function fetchUser(id) {
  try {
    const res = await fetch(`/api/users/${id}`);
    if (!res.ok) throw new Error('Not found');
    return await res.json();
  } catch (err) {
    console.error(err);
  }
}
```

**Event loop & microtask queue**

JavaScript is single-threaded. The event loop processes:
1. **Call stack** — synchronous code
2. **Microtask queue** — Promise `.then`, `queueMicrotask` (runs before next task)
3. **Macrotask queue** — `setTimeout`, `setInterval`, I/O callbacks

```js
console.log('1');
setTimeout(() => console.log('4'), 0);
Promise.resolve().then(() => console.log('3'));
console.log('2');
// Output: 1, 2, 3, 4
```

---

### 1.3 Closures & Scope

A **closure** is a function that retains access to its lexical scope even when executed outside that scope.

```js
function makeCounter() {
  let count = 0;
  return {
    increment: () => ++count,
    decrement: () => --count,
    value: () => count,
  };
}

const counter = makeCounter();
counter.increment(); // 1
counter.increment(); // 2
```

Closures are everywhere in React — every function component body is a closure over its props and state snapshot.

**Stale closure problem in React:**

```js
// ❌ Stale closure — count is captured at render time
useEffect(() => {
  const id = setInterval(() => {
    setCount(count + 1); // always adds to the same `count` value
  }, 1000);
  return () => clearInterval(id);
}, []); // empty deps — never re-runs

// ✅ Functional update — no closure over `count`
useEffect(() => {
  const id = setInterval(() => {
    setCount(c => c + 1);
  }, 1000);
  return () => clearInterval(id);
}, []);
```

---

### 1.4 Array & Object Methods

```js
const users = [
  { name: 'Alice', age: 30, active: true },
  { name: 'Bob',   age: 25, active: false },
  { name: 'Carol', age: 35, active: true },
];

// map — transform
const names = users.map(u => u.name); // ['Alice', 'Bob', 'Carol']

// filter — subset
const active = users.filter(u => u.active);

// reduce — aggregate
const totalAge = users.reduce((sum, u) => sum + u.age, 0);

// find — first match
const alice = users.find(u => u.name === 'Alice');

// some / every
const anyActive = users.some(u => u.active);    // true
const allActive = users.every(u => u.active);   // false

// Immutable update patterns (key for React state)
const updated = users.map(u =>
  u.name === 'Bob' ? { ...u, active: true } : u
);
const without = users.filter(u => u.name !== 'Bob');
const added = [...users, { name: 'Dave', age: 28, active: true }];
```

---

## 2. React Core Concepts

### 2.1 JSX

JSX is syntactic sugar compiled to `React.createElement` calls (or the new JSX transform in React 17+).

```jsx
// JSX
const element = <h1 className="title">Hello, {name}</h1>;

// Compiled (old transform)
const element = React.createElement('h1', { className: 'title' }, 'Hello, ', name);
```

**Conditional rendering patterns:**

```jsx
// Ternary
{isLoggedIn ? <Dashboard /> : <Login />}

// Short-circuit (renders nothing when false)
{error && <ErrorBanner message={error} />}

// Early return
function Profile({ user }) {
  if (!user) return null;
  return <div>{user.name}</div>;
}
```

**List rendering — always use stable keys:**

```jsx
{items.map(item => (
  <ListItem key={item.id} item={item} />  // ✅ stable, unique id
))}

// ❌ Avoid index as key when list can reorder/filter
{items.map((item, index) => (
  <ListItem key={index} item={item} />
))}
```

---

### 2.2 Components

**Functional components** are plain JS functions returning JSX. They are the standard since hooks arrived.

```jsx
function Button({ label, onClick, disabled = false }) {
  return (
    <button onClick={onClick} disabled={disabled}>
      {label}
    </button>
  );
}
```

**Props** are read-only. A component must never mutate its own props.

**Children prop:**

```jsx
function Card({ title, children }) {
  return (
    <div className="card">
      <h2>{title}</h2>
      <div className="body">{children}</div>
    </div>
  );
}

// Usage
<Card title="Profile">
  <Avatar src={user.photo} />
  <p>{user.bio}</p>
</Card>
```

---

### 2.3 State Management (useState)

```jsx
const [count, setCount] = useState(0);

// Direct update
setCount(5);

// Functional update — use when new state depends on old state
setCount(prev => prev + 1);

// Object state — always spread to avoid mutation
const [form, setForm] = useState({ name: '', email: '' });
setForm(prev => ({ ...prev, email: 'new@example.com' }));
```

**Lifting state up** — when two sibling components need to share state, move it to their closest common ancestor.

```jsx
function Parent() {
  const [value, setValue] = useState('');
  return (
    <>
      <Input value={value} onChange={setValue} />
      <Preview value={value} />
    </>
  );
}
```

---

### 2.4 Component Lifecycle (conceptual)

| Phase | Class method | Hook equivalent |
|-------|-------------|-----------------|
| Mount | `componentDidMount` | `useEffect(() => { ... }, [])` |
| Update | `componentDidUpdate` | `useEffect(() => { ... }, [dep])` |
| Unmount | `componentWillUnmount` | `useEffect(() => { return cleanup; }, [])` |

```jsx
useEffect(() => {
  const subscription = subscribe(userId);   // mount / update
  return () => subscription.unsubscribe();  // cleanup / unmount
}, [userId]);
```

---

## 3. React Hooks (Deep Dive)

### 3.1 Core Hooks

**useState** — stores local component state.

**useEffect** — synchronises a component with an external system.

```jsx
useEffect(() => {
  document.title = `${count} notifications`;
}, [count]); // runs whenever `count` changes
```

**useContext** — reads a context value without prop drilling.

```jsx
const theme = useContext(ThemeContext);
```

**useRef** — holds a mutable value that persists across renders without causing re-renders.

```jsx
// DOM reference
const inputRef = useRef(null);
<input ref={inputRef} />
inputRef.current.focus();

// Mutable instance value (like an instance variable)
const timerRef = useRef(null);
timerRef.current = setTimeout(...);
```

**useReducer** — manages complex state with a reducer function.

```jsx
function reducer(state, action) {
  switch (action.type) {
    case 'increment': return { count: state.count + 1 };
    case 'reset':     return { count: 0 };
    default: throw new Error('Unknown action');
  }
}

const [state, dispatch] = useReducer(reducer, { count: 0 });
dispatch({ type: 'increment' });
```

**useMemo** — memoizes an expensive computed value.

```jsx
const sorted = useMemo(
  () => [...items].sort(compareByDate),
  [items]
);
```

**useCallback** — memoizes a function reference to prevent child re-renders.

```jsx
const handleSubmit = useCallback(() => {
  submitForm(formData);
}, [formData]);
```

---

### 3.2 Rules of Hooks

1. **Only call hooks at the top level** — never inside conditionals, loops, or nested functions.
2. **Only call hooks from React functions** — functional components or custom hooks.

These rules exist because React relies on the call order of hooks to associate state correctly between renders.

```jsx
// ❌ Conditional hook call
if (isLoggedIn) {
  const user = useContext(UserContext); // breaks rules
}

// ✅ Call hook unconditionally, use value conditionally
const user = useContext(UserContext);
if (isLoggedIn) { /* use user */ }
```

---

### 3.3 Custom Hooks

Custom hooks are functions prefixed with `use` that encapsulate stateful logic for reuse.

```jsx
// useFetch — data fetching hook
function useFetch(url) {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    let cancelled = false;
    setLoading(true);
    fetch(url)
      .then(r => r.json())
      .then(d => { if (!cancelled) setData(d); })
      .catch(e => { if (!cancelled) setError(e); })
      .finally(() => { if (!cancelled) setLoading(false); });
    return () => { cancelled = true; };
  }, [url]);

  return { data, loading, error };
}

// useDebounce
function useDebounce(value, delay = 300) {
  const [debounced, setDebounced] = useState(value);
  useEffect(() => {
    const id = setTimeout(() => setDebounced(value), delay);
    return () => clearTimeout(id);
  }, [value, delay]);
  return debounced;
}
```

---

### 3.4 React 18 Hooks

**useTransition** — marks state updates as non-urgent, keeping the UI responsive.

```jsx
const [isPending, startTransition] = useTransition();

startTransition(() => {
  setSearchQuery(input); // non-urgent — can be interrupted
});
```

**useDeferredValue** — defers re-rendering an expensive child.

```jsx
const deferredQuery = useDeferredValue(query);
// Pass deferredQuery to heavy list — it lags behind intentionally
```

**useId** — generates stable unique IDs for accessibility attributes.

```jsx
const id = useId();
return <label htmlFor={id}>Email<input id={id} /></label>;
```

---

## 4. Rendering & Performance

### 4.1 React Rendering Model

**Virtual DOM** — React maintains a lightweight JS representation of the DOM. On state change, it re-renders the component tree in memory, diffs the new and old virtual trees (reconciliation), and applies only the necessary real DOM mutations.

**Fiber architecture** — React's reconciliation engine. It splits rendering work into small units that can be paused, resumed, or abandoned, enabling concurrent features.

**Concurrent rendering (React 18)** — React can prepare multiple versions of the UI simultaneously and prioritise urgent updates (user input) over background work (search results rendering).

**Render phases:**

| Phase | What happens | Side effects? |
|-------|-------------|---------------|
| Render | React calls your component functions, builds new virtual tree | No |
| Commit | React applies DOM changes, runs `useEffect` cleanup & setup | Yes |

---

### 4.2 Re-render Optimisation

A component re-renders when its **state changes**, its **parent re-renders**, or its **context value changes**.

**React.memo** — wraps a component so it only re-renders when its props change (shallow comparison).

```jsx
const ExpensiveList = React.memo(function ExpensiveList({ items }) {
  return items.map(i => <Item key={i.id} {...i} />);
});
```

**useMemo & useCallback** — stabilise values and functions passed as props to memoized children.

```jsx
// Without useCallback, new function reference each render → memo broken
const handleClick = useCallback(() => {
  doSomething(id);
}, [id]);

<ExpensiveList onSelect={handleClick} /> // ✅ stable reference
```

**When NOT to memoize:** Memoisation has overhead. Skip it for:
- Components that always receive new props
- Cheap computations
- Components that almost always re-render anyway

---

### 4.3 Code Splitting & Lazy Loading

```jsx
const Dashboard = React.lazy(() => import('./Dashboard'));

function App() {
  return (
    <Suspense fallback={<Spinner />}>
      <Dashboard />
    </Suspense>
  );
}
```

Route-level splitting with React Router:

```jsx
const Home = lazy(() => import('./pages/Home'));
const Profile = lazy(() => import('./pages/Profile'));

<Routes>
  <Route path="/" element={<Suspense fallback={<Loading />}><Home /></Suspense>} />
  <Route path="/profile" element={<Suspense fallback={<Loading />}><Profile /></Suspense>} />
</Routes>
```

---

### 4.4 Profiling Tools

Use **React DevTools Profiler** (browser extension) to:
- Record interactions and see which components rendered
- View render durations and "why did this render?" reasons
- Identify components that render too frequently

---

## 5. State Management

### 5.1 Context API

Context solves prop drilling — passing data through many layers of components.

```jsx
// 1. Create
const ThemeContext = createContext('light');

// 2. Provide
function App() {
  const [theme, setTheme] = useState('light');
  return (
    <ThemeContext.Provider value={{ theme, setTheme }}>
      <Layout />
    </ThemeContext.Provider>
  );
}

// 3. Consume
function Button() {
  const { theme } = useContext(ThemeContext);
  return <button className={theme}>Click</button>;
}
```

**Performance pitfall:** Every consumer re-renders when the context value changes. Split unrelated data into separate contexts.

---

### 5.2 useReducer Pattern

Best for state with multiple sub-values or complex update logic.

```jsx
const initialState = { count: 0, step: 1 };

function reducer(state, action) {
  switch (action.type) {
    case 'increment':   return { ...state, count: state.count + state.step };
    case 'decrement':   return { ...state, count: state.count - state.step };
    case 'setStep':     return { ...state, step: action.payload };
    case 'reset':       return initialState;
    default:            return state;
  }
}

const [state, dispatch] = useReducer(reducer, initialState);
```

---

### 5.3 Redux & Redux Toolkit

**Redux Toolkit (RTK)** is the official, recommended way to use Redux.

```js
// counterSlice.js
import { createSlice } from '@reduxjs/toolkit';

const counterSlice = createSlice({
  name: 'counter',
  initialState: { value: 0 },
  reducers: {
    increment: state => { state.value += 1; },  // RTK uses Immer — safe mutation
    decrement: state => { state.value -= 1; },
    incrementByAmount: (state, action) => { state.value += action.payload; },
  },
});

export const { increment, decrement, incrementByAmount } = counterSlice.actions;
export default counterSlice.reducer;
```

```jsx
// In a component
const count = useSelector(state => state.counter.value);
const dispatch = useDispatch();
<button onClick={() => dispatch(increment())}>+</button>
```

**createAsyncThunk** for async actions:

```js
export const fetchUser = createAsyncThunk('users/fetch', async (userId) => {
  const res = await fetch(`/api/users/${userId}`);
  return res.json();
});
```

---

### 5.4 Other State Libraries

| Library | Model | Best for |
|---------|-------|----------|
| **Zustand** | Single store, hook-based | Lightweight global state |
| **Jotai** | Atomic (bottom-up) | Fine-grained reactivity |
| **TanStack Query** | Server state cache | Async data, caching, sync |
| **Recoil** | Atomic (Facebook) | Large apps with shared atoms |

**TanStack Query** is worth highlighting — it handles loading, error, caching, background refetching, and pagination out of the box.

```jsx
const { data, isLoading, error } = useQuery({
  queryKey: ['users', userId],
  queryFn: () => fetchUser(userId),
  staleTime: 5 * 60 * 1000, // 5 minutes
});
```

---

## 6. Routing

### 6.1 React Router v6

```jsx
import { BrowserRouter, Routes, Route, Link, Outlet } from 'react-router-dom';

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Layout />}>
          <Route index element={<Home />} />
          <Route path="users" element={<Users />} />
          <Route path="users/:id" element={<UserProfile />} />
          <Route path="*" element={<NotFound />} />
        </Route>
      </Routes>
    </BrowserRouter>
  );
}

function Layout() {
  return (
    <div>
      <nav><Link to="/">Home</Link></nav>
      <Outlet />  {/* nested routes render here */}
    </div>
  );
}
```

**Hooks:**

```jsx
const { id } = useParams();            // URL parameters
const navigate = useNavigate();        // programmatic navigation
const location = useLocation();        // current location object
const [params, setParams] = useSearchParams(); // ?key=value
```

---

### 6.2 Advanced Routing

**Protected routes:**

```jsx
function ProtectedRoute({ children }) {
  const { user } = useAuth();
  if (!user) return <Navigate to="/login" replace />;
  return children;
}

<Route path="/dashboard" element={
  <ProtectedRoute><Dashboard /></ProtectedRoute>
} />
```

---

## 7. Forms & Validation

### 7.1 Controlled vs Uncontrolled

**Controlled** — React owns the value; input is always in sync with state.

```jsx
const [email, setEmail] = useState('');
<input value={email} onChange={e => setEmail(e.target.value)} />
```

**Uncontrolled** — DOM owns the value; read it via ref when needed.

```jsx
const inputRef = useRef();
<input ref={inputRef} defaultValue="initial" />
// read: inputRef.current.value
```

Use controlled for most cases. Use uncontrolled for file inputs or when integrating with non-React code.

---

### 7.2 React Hook Form

Performant forms with minimal re-renders — inputs are uncontrolled by default.

```jsx
import { useForm } from 'react-hook-form';

function SignupForm() {
  const { register, handleSubmit, formState: { errors } } = useForm();

  const onSubmit = data => console.log(data);

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <input {...register('email', {
        required: 'Email is required',
        pattern: { value: /\S+@\S+/, message: 'Invalid email' }
      })} />
      {errors.email && <p>{errors.email.message}</p>}
      <button type="submit">Sign up</button>
    </form>
  );
}
```

---

### 7.3 Validation with Zod

```js
import { z } from 'zod';
import { zodResolver } from '@hookform/resolvers/zod';

const schema = z.object({
  email: z.string().email('Invalid email'),
  password: z.string().min(8, 'At least 8 characters'),
  age: z.number().min(18, 'Must be 18+'),
});

const { register, handleSubmit, formState: { errors } } = useForm({
  resolver: zodResolver(schema),
});
```

---

## 8. Styling Approaches

### 8.1 CSS Modules

Class names are locally scoped — no global collisions.

```css
/* Button.module.css */
.button { padding: 8px 16px; border-radius: 4px; }
.primary { background: #007bff; color: white; }
```

```jsx
import styles from './Button.module.css';
<button className={`${styles.button} ${styles.primary}`}>Click</button>
```

### 8.2 Tailwind CSS

Utility classes applied directly in JSX.

```jsx
<button className="px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600 transition">
  Click
</button>
```

Use `clsx` or `classnames` to conditionally apply classes:

```jsx
import clsx from 'clsx';
<div className={clsx('card', { 'card--active': isActive, 'card--disabled': disabled })} />
```

### 8.3 Styled Components

```jsx
import styled from 'styled-components';

const Button = styled.button`
  padding: 8px 16px;
  background: ${props => props.primary ? '#007bff' : 'white'};
  color: ${props => props.primary ? 'white' : '#007bff'};
  border-radius: 4px;
`;

<Button primary>Primary</Button>
<Button>Secondary</Button>
```

---

## 9. Data Fetching & Side Effects

### 9.1 Fetching with useEffect

```jsx
function UserProfile({ userId }) {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    let cancelled = false;  // prevent race conditions
    setLoading(true);

    fetch(`/api/users/${userId}`)
      .then(r => { if (!r.ok) throw new Error('Failed'); return r.json(); })
      .then(data => { if (!cancelled) setUser(data); })
      .catch(err => { if (!cancelled) setError(err.message); })
      .finally(() => { if (!cancelled) setLoading(false); });

    return () => { cancelled = true; };  // cleanup
  }, [userId]);

  if (loading) return <Spinner />;
  if (error) return <Error message={error} />;
  return <Profile user={user} />;
}
```

### 9.2 TanStack Query (React Query)

```jsx
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';

// Fetching
const { data, isLoading, error } = useQuery({
  queryKey: ['user', userId],
  queryFn: () => fetch(`/api/users/${userId}`).then(r => r.json()),
});

// Mutating with optimistic update
const queryClient = useQueryClient();

const mutation = useMutation({
  mutationFn: (updates) => fetch(`/api/users/${userId}`, {
    method: 'PATCH',
    body: JSON.stringify(updates),
  }),
  onMutate: async (updates) => {
    await queryClient.cancelQueries(['user', userId]);
    const previous = queryClient.getQueryData(['user', userId]);
    queryClient.setQueryData(['user', userId], old => ({ ...old, ...updates }));
    return { previous };
  },
  onError: (err, updates, context) => {
    queryClient.setQueryData(['user', userId], context.previous);
  },
  onSettled: () => {
    queryClient.invalidateQueries(['user', userId]);
  },
});
```

---

## 10. Testing

### 10.1 React Testing Library Philosophy

Test your app the way users use it — interact with the DOM, not component internals. Avoid testing implementation details.

```jsx
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';

test('submits login form', async () => {
  const user = userEvent.setup();
  render(<LoginForm onSubmit={mockSubmit} />);

  await user.type(screen.getByLabelText('Email'), 'alice@example.com');
  await user.type(screen.getByLabelText('Password'), 'secret123');
  await user.click(screen.getByRole('button', { name: /sign in/i }));

  expect(mockSubmit).toHaveBeenCalledWith({
    email: 'alice@example.com',
    password: 'secret123',
  });
});
```

**Query priority (prefer in this order):**

1. `getByRole` — most accessible, mirrors how screen readers work
2. `getByLabelText` — for form elements
3. `getByPlaceholderText`
4. `getByText`
5. `getByTestId` — last resort

**Async queries:**

```jsx
// findBy* — returns a Promise, use with await
const element = await screen.findByText('Welcome, Alice');

// waitFor — wait for condition
await waitFor(() => expect(mockFn).toHaveBeenCalled());
```

### 10.2 Mocking

```jsx
// Mock a module
jest.mock('../api', () => ({
  fetchUser: jest.fn().mockResolvedValue({ name: 'Alice' }),
}));

// Mock fetch
global.fetch = jest.fn().mockResolvedValue({
  ok: true,
  json: () => Promise.resolve({ id: 1 }),
});
```

---

## 11. TypeScript with React

### 11.1 Typing Components

```tsx
interface ButtonProps {
  label: string;
  onClick: () => void;
  variant?: 'primary' | 'secondary' | 'danger';
  disabled?: boolean;
  children?: React.ReactNode;
}

function Button({ label, onClick, variant = 'primary', disabled = false }: ButtonProps) {
  return <button onClick={onClick} disabled={disabled} className={variant}>{label}</button>;
}
```

### 11.2 Typing Hooks

```tsx
const [user, setUser] = useState<User | null>(null);
const [count, setCount] = useState(0);             // inferred as number

const inputRef = useRef<HTMLInputElement>(null);
inputRef.current?.focus();

// Custom hook return type
function useCounter(initial: number): [number, () => void, () => void] {
  const [count, setCount] = useState(initial);
  return [count, () => setCount(c => c + 1), () => setCount(c => c - 1)];
}
```

### 11.3 Event Typing

```tsx
const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
  setValue(e.target.value);
};

const handleSubmit = (e: React.FormEvent<HTMLFormElement>) => {
  e.preventDefault();
};

const handleClick = (e: React.MouseEvent<HTMLButtonElement>) => {
  console.log(e.currentTarget.name);
};
```

### 11.4 Advanced Patterns

**Generic components:**

```tsx
interface ListProps<T> {
  items: T[];
  renderItem: (item: T) => React.ReactNode;
  keyExtractor: (item: T) => string;
}

function List<T>({ items, renderItem, keyExtractor }: ListProps<T>) {
  return <ul>{items.map(item => <li key={keyExtractor(item)}>{renderItem(item)}</li>)}</ul>;
}
```

**Discriminated unions for variants:**

```tsx
type AlertProps =
  | { type: 'success'; message: string }
  | { type: 'error'; message: string; retryFn: () => void }
  | { type: 'loading' };

function Alert(props: AlertProps) {
  if (props.type === 'loading') return <Spinner />;
  if (props.type === 'error') return <div onClick={props.retryFn}>{props.message}</div>;
  return <div>{props.message}</div>;
}
```

---

## 12. Architecture & Patterns

### 12.1 Design Patterns

**Compound components** — components that share implicit state through context.

```jsx
function Tabs({ children, defaultTab }) {
  const [active, setActive] = useState(defaultTab);
  return (
    <TabsContext.Provider value={{ active, setActive }}>
      <div className="tabs">{children}</div>
    </TabsContext.Provider>
  );
}

Tabs.List = function TabList({ children }) { return <div role="tablist">{children}</div>; };
Tabs.Tab = function Tab({ id, children }) {
  const { active, setActive } = useContext(TabsContext);
  return <button role="tab" aria-selected={active === id} onClick={() => setActive(id)}>{children}</button>;
};
Tabs.Panel = function Panel({ id, children }) {
  const { active } = useContext(TabsContext);
  return active === id ? <div role="tabpanel">{children}</div> : null;
};

// Usage
<Tabs defaultTab="profile">
  <Tabs.List>
    <Tabs.Tab id="profile">Profile</Tabs.Tab>
    <Tabs.Tab id="settings">Settings</Tabs.Tab>
  </Tabs.List>
  <Tabs.Panel id="profile"><ProfileContent /></Tabs.Panel>
  <Tabs.Panel id="settings"><SettingsContent /></Tabs.Panel>
</Tabs>
```

**Higher-Order Components (HOC):**

```jsx
function withAuth(WrappedComponent) {
  return function AuthenticatedComponent(props) {
    const { user } = useAuth();
    if (!user) return <Redirect to="/login" />;
    return <WrappedComponent {...props} user={user} />;
  };
}

const ProtectedDashboard = withAuth(Dashboard);
```

### 12.2 Error Boundaries

Error boundaries catch JS errors anywhere in their child tree and render a fallback UI.

```jsx
import { ErrorBoundary } from 'react-error-boundary';

function ErrorFallback({ error, resetErrorBoundary }) {
  return (
    <div role="alert">
      <p>Something went wrong: {error.message}</p>
      <button onClick={resetErrorBoundary}>Try again</button>
    </div>
  );
}

<ErrorBoundary FallbackComponent={ErrorFallback} onError={logError}>
  <App />
</ErrorBoundary>
```

### 12.3 Portals

Render a component outside its parent DOM node — useful for modals, tooltips, and toasts.

```jsx
import { createPortal } from 'react-dom';

function Modal({ children, onClose }) {
  return createPortal(
    <div className="modal-overlay" onClick={onClose}>
      <div className="modal-content" onClick={e => e.stopPropagation()}>
        {children}
      </div>
    </div>,
    document.getElementById('modal-root')
  );
}
```

### 12.4 forwardRef

Exposes a DOM ref to a parent component.

```jsx
const Input = forwardRef(function Input({ label, ...props }, ref) {
  return (
    <label>
      {label}
      <input ref={ref} {...props} />
    </label>
  );
});

// Parent
const inputRef = useRef();
<Input ref={inputRef} label="Email" />
inputRef.current.focus();
```

---

## 13. Next.js & SSR

### 13.1 Rendering Strategies

| Strategy | When HTML generated | Data freshness | Use case |
|----------|--------------------|--------------|---------| 
| **CSR** | In the browser | On every client visit | Dashboards, authenticated pages |
| **SSR** | On each request | Always fresh | SEO pages with dynamic data |
| **SSG** | At build time | Stale until rebuild | Marketing, blogs, docs |
| **ISR** | At build + revalidation | Fresh within interval | Product listings, news |

### 13.2 Next.js App Router

```
app/
  layout.tsx        → root layout (always rendered)
  page.tsx          → index route (/)
  loading.tsx       → Suspense fallback
  error.tsx         → error boundary
  users/
    page.tsx        → /users
    [id]/
      page.tsx      → /users/:id
```

**Server vs Client components:**

```tsx
// Server component (default) — runs only on server
// Can: fetch data directly, access backend resources, reduce JS bundle
// Cannot: use hooks, event listeners, browser APIs

async function UserProfile({ id }: { id: string }) {
  const user = await db.user.findUnique({ where: { id } }); // direct DB access
  return <Profile user={user} />;
}

// Client component — add 'use client' directive
'use client';

import { useState } from 'react';

function Counter() {
  const [count, setCount] = useState(0);
  return <button onClick={() => setCount(c => c + 1)}>{count}</button>;
}
```

### 13.3 Data Fetching in Next.js

```tsx
// Cached by default — can opt into revalidation
const res = await fetch('https://api.example.com/data', {
  next: { revalidate: 60 },   // ISR — revalidate every 60s
  // cache: 'no-store'        // SSR — never cache
});
```

---

## 14. Accessibility (a11y)

### 14.1 Semantic HTML & ARIA

Use semantic HTML elements first — they come with built-in accessibility.

```jsx
// ❌ div soup
<div onClick={handleClick}>Submit</div>

// ✅ Semantic element — keyboard accessible, announces as button
<button onClick={handleClick}>Submit</button>
```

**ARIA** supplements semantic HTML when native elements are insufficient:

```jsx
// Live region — announces dynamic content to screen readers
<div aria-live="polite" aria-atomic="true">
  {statusMessage}
</div>

// Labelling custom controls
<div
  role="slider"
  aria-valuemin={0}
  aria-valuemax={100}
  aria-valuenow={volume}
  aria-label="Volume"
  tabIndex={0}
  onKeyDown={handleKeyDown}
/>
```

### 14.2 Keyboard & Focus

```jsx
// Manage focus after opening a modal
const closeButtonRef = useRef(null);

useEffect(() => {
  if (isOpen) closeButtonRef.current?.focus();
}, [isOpen]);

// Trap focus inside modal
function useFocusTrap(ref) {
  useEffect(() => {
    const el = ref.current;
    const focusable = el.querySelectorAll('button, input, a[href], [tabindex]:not([tabindex="-1"])');
    const first = focusable[0];
    const last = focusable[focusable.length - 1];

    const trap = (e) => {
      if (e.key !== 'Tab') return;
      if (e.shiftKey && document.activeElement === first) { e.preventDefault(); last.focus(); }
      else if (!e.shiftKey && document.activeElement === last) { e.preventDefault(); first.focus(); }
    };

    el.addEventListener('keydown', trap);
    return () => el.removeEventListener('keydown', trap);
  }, [ref]);
}
```

### 14.3 Testing a11y

```jsx
import { axe, toHaveNoViolations } from 'jest-axe';
expect.extend(toHaveNoViolations);

test('has no a11y violations', async () => {
  const { container } = render(<LoginForm />);
  expect(await axe(container)).toHaveNoViolations();
});
```

---

## 15. Common Interview Questions

### 15.1 Key Conceptual Questions

**Q: What is the virtual DOM and why does React use it?**

The virtual DOM is an in-memory JS representation of the real DOM. React uses it to batch and minimise expensive real DOM operations. When state changes, React renders to the virtual DOM, diffs it against the previous version (reconciliation), and applies only the minimal set of real DOM changes needed.

**Q: Why do list items need keys?**

Keys help React identify which items in a list have changed, been added, or removed. Without stable keys, React may re-render or reorder the wrong elements, causing bugs with component state (e.g., input values sticking to the wrong list item).

**Q: What triggers a re-render?**

- `setState` / `useState` setter called
- Parent component re-renders (unless `React.memo` blocks it)
- `useContext` value changes
- `useReducer` dispatch called

**Q: Explain the useEffect dependency array.**

- `[]` — effect runs once on mount
- `[a, b]` — effect runs when `a` or `b` changes
- No array — effect runs after every render
- Cleanup function — runs before the next effect run or on unmount

**Q: What is the difference between useMemo and useCallback?**

- `useMemo` memoises a **computed value**: `useMemo(() => expensiveCalc(a, b), [a, b])`
- `useCallback` memoises a **function reference**: `useCallback(() => doSomething(a), [a])`

---

### 15.2 Coding Challenge Examples

**Build a debounce hook:**

```jsx
function useDebounce(value, delay = 300) {
  const [debouncedValue, setDebouncedValue] = useState(value);

  useEffect(() => {
    const timer = setTimeout(() => setDebouncedValue(value), delay);
    return () => clearTimeout(timer);
  }, [value, delay]);

  return debouncedValue;
}
```

**Build an infinite scroll hook:**

```jsx
function useInfiniteScroll(callback) {
  const observerRef = useRef(null);

  const lastElementRef = useCallback(node => {
    if (observerRef.current) observerRef.current.disconnect();
    observerRef.current = new IntersectionObserver(entries => {
      if (entries[0].isIntersecting) callback();
    });
    if (node) observerRef.current.observe(node);
  }, [callback]);

  return lastElementRef;
}
```

---

### 15.3 System Design Principles

When designing a React architecture at scale, consider:

- **State boundaries** — what is server state (use TanStack Query), global UI state (Zustand/Context), and local state (useState)?
- **Code splitting strategy** — split at route level by default, split heavy libraries (charts, editors) lazily.
- **Component granularity** — too coarse means unnecessary re-renders; too fine means prop drilling complexity.
- **Error handling** — wrap route-level subtrees in error boundaries; surface meaningful fallback UIs.
- **Performance budget** — define acceptable Lighthouse scores early; enforce with CI checks.

---

*Good luck with your interview! The best preparation combines reading with building — try to implement each pattern by hand at least once.*
