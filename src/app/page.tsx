import { Metadata } from "next";
import Link from "next/link";
const blogs = [
  {
    slug: "first-blog",
    title: "first blog",
  },
  {
    slug: "second-blog",
    title: "second blog",
  },
];
export const metadata:Metadata={
  title:"mg blog",
}
export default function Home() {
  return (
    <main>
      blogs
      <ul>
        {blogs.map((blog) => (
          <li>
            <Link href={`/blogs/${blog.slug}`}>{blog.title}</Link>
          </li>
        ))}
      </ul>
    </main>
  );
}
